// Licensed to the StackStorm, Inc ('StackStorm') under one or more
// contributor license agreements.  See the NOTICE file distributed with
// this work for additional information regarding copyright ownership.
// The ASF licenses this file to You under the Apache License, Version 2.0
// (the "License"); you may not use this file except in compliance with
// the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// End-to-end smoke test: starts the packaged bot (bin/hubot --test, hubot's Shell adapter) against
// a running StackStorm and talks to it on stdin, so no chat service is needed. The ST2_* and
// HUBOT_* settings come from the environment, as for the service (see st2chatops.env).
// Only the core `packs` aliases are used, and `pack get` is read-only.
'use strict';

const { test, before, after } = require('node:test');
const assert = require('node:assert');
const { spawn } = require('node:child_process');
const path = require('node:path');

const HUBOT = path.join(__dirname, '..', 'bin', 'hubot');
const ALIAS = process.env.HUBOT_ALIAS || '!';

let bot;
let output = '';

// resolves with the first match of `pattern` in what the bot prints after `from`
function waitFor(pattern, from, timeout = 60000) {
  return new Promise((resolve, reject) => {
    const check = () => {
      const match = output.slice(from).match(pattern);
      if (match) {
        clearInterval(poll);
        clearTimeout(timer);
        resolve(match);
      }
    };
    const poll = setInterval(check, 100);
    const timer = setTimeout(() => {
      clearInterval(poll);
      reject(new Error(`no ${pattern} within ${timeout / 1000}s; the bot printed:\n${output.slice(from)}`));
    }, timeout);
    check();
  });
}

function say(text) {
  const from = output.length;
  bot.stdin.write(`${text}\n`);
  return from;
}

before(async () => {
  bot = spawn(HUBOT, [ '--test' ], {
    env: { ...process.env, HUBOT_LOG_LEVEL: 'info' },
    stdio: [ 'pipe', 'pipe', 'pipe' ],
  });
  for (const stream of [ bot.stdout, bot.stderr ]) {
    // drop the Shell adapter's colours
    stream.on('data', (data) => { output += data.toString().replace(/\x1b\[[0-9;]*m/g, ''); });
  }
  await waitFor(/(\d+) commands are loaded/, 0);
});

after(() => {
  if (bot && bot.exitCode === null) {
    bot.stdin.end('exit\n');
    bot.kill();
  }
});

test('logs in to StackStorm and loads its action aliases', async () => {
  const [ , count ] = await waitFor(/(\d+) commands are loaded/, 0);
  assert.ok(Number(count) > 0, 'no aliases loaded');
  assert.doesNotMatch(output, /Failed to (retrieve commands|authenticate)/);
});

test('lists the aliases in help', async () => {
  const from = say(`${ALIAS}help pack`);
  await waitFor(new RegExp(`\\${ALIAS}pack get <pack> - Get information about installed StackStorm pack`), from);
});

test('lists the aliases when help is addressed by name too', async () => {
  // hubot 14's built-in help would answer this one; scripts/st2-help.js hands it to hubot-help
  const from = say(`${process.env.HUBOT_NAME || 'hubot'} help pack`);
  await waitFor(/pack get <pack> - Get information about installed StackStorm pack/, from);
});

test('runs an alias and posts the result back to chat', async () => {
  // the reply arrives through StackStorm: execution -> chatops.notify rule -> stream -> hubot
  const from = say(`${ALIAS}pack get core`);
  await waitFor(/Getting back to you about the installed `core` pack/, from, 90000);
  await waitFor(/name: core/, from, 10000);
});

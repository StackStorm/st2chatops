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

const { test } = require('node:test');
const assert = require('node:assert');

const help = require('../scripts/st2-help');

const logger = { debug() {} };

test('removes hubot 14\'s built-in help, so hubot-help answers "@bot help"', () => {
  const registered = new Map([ [ 'help', {} ], [ 'tickets.create', {} ] ]);
  const robot = {
    logger,
    commands: {
      getCommand: (id) => registered.get(id),
      unregister: (id) => registered.delete(id),
    },
  };

  help(robot);

  assert.deepStrictEqual([ ...registered.keys() ], [ 'tickets.create' ]);
});

test('leaves hubot 13 and earlier alone, where robot.commands is the help list', () => {
  const robot = { logger, commands: [ 'hubot help - Displays all of the help commands' ] };

  help(robot);

  assert.deepStrictEqual(robot.commands, [ 'hubot help - Displays all of the help commands' ]);
});

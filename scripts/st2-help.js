// Description:
//   Lets hubot-help answer "@<bot> help" on hubot 14.
//
// Notes:
//   hubot 14 added a built-in `help` command. It answers messages addressed by the bot's name
//   ("@<bot> help") before any script sees them, and it only lists commands registered on hubot's
//   CommandBus. The StackStorm aliases are in hubot-help's list instead, so this removes the
//   built-in command: hubot-help then answers "@<bot> help" and "!help" alike, as on earlier
//   hubot versions.

'use strict';

module.exports = (robot) => {
  const commands = robot.commands;
  if (commands && typeof commands.unregister === 'function' && commands.getCommand('help')) {
    commands.unregister('help');
    robot.logger.debug('st2chatops: "help" is answered by hubot-help, not hubot\'s built-in command');
  }
};

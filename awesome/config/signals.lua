local awful = require('lib.awful')


-- 🛑 Signals And Rules 🛑 --
client.connect_signal('manage', require('config.manage'))
client.connect_signal('mouse::enter', function(c) c:emit_signal('request::activate', 'mouse_enter', { raise = false }) end)

awful.rules.rules = require('config.rules')
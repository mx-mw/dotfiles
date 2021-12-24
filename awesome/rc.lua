pcall(require, 'luarocks.loader')

-- 🐈 Modules 🐈 --
require('lib.awful.autofocus')
require('theme')
require('lib.awful.hotkeys_popup.keys')
require('config')
require('decorations')
require('widgets')
-- Constants so vscode will stop being a bitch
root = root
client = client
screen = screen
awesome = awesome
mouse = mouse
tag = tag
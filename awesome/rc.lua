pcall(require, 'luarocks.loader')

-- 🐈 Modules 🐈 --
require('awful.autofocus')
require('theme')
require('awful.hotkeys_popup.keys')
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
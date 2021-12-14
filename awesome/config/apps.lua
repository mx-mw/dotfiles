Apps               = {}
Apps.terminal      = 'kitty'
Apps.screen_shot   = 'shutter -s'
Apps.wallpaper     = 'nitrogen --restore'
Apps.compositor    = 'picom'
Apps.launcher      = 'rofi'
Apps.browser       = 'firefox'
Apps.editor        = 'code'
Apps.file_explorer = 'thunar'
Apps.email         = 'thunderbird'
Apps.music         = 'spotify'
Apps.discord       = 'discord'

local menubar = require('menubar')

-- Menubar configuration
menubar.utils.terminal = Apps.terminal -- Set the terminal for applications that require it

return Apps

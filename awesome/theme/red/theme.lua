------------
-- Lucius --
------------
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local theme_assets = require('beautiful.theme_assets')
local gears = require('gears')
local theme = {}
local conf = require('conf')


-- table.insert(theme, require('theme.basic'))
theme = gears.table.join(
    theme,
    require('theme.red.basic'),
    require('theme.red.layout'),
    require('theme.red.notification'),
    require('theme.red.titlebar'),
    require('theme.red.topbar'),
    require('theme.red.colors')
)


theme.wallpaper = "/home/max/.config/awesome/theme/leaves.jpeg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

theme.icon_theme = nil

theme.titlebar_height = dpi(28)
return theme

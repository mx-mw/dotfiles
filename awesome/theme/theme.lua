local xresources = require('lib.beautiful.xresources')
local dpi = xresources.apply_dpi

local theme_assets = require('lib.beautiful.theme_assets')
local gears = require('lib.gears')
local theme = {}
local conf = require('conf')

theme = gears.table.join(
	theme,
	require('theme.'..conf.DEFAULT_COLOR_THEME..'.basic'),
	require('theme.'..conf.DEFAULT_COLOR_THEME..'.layout'),
	require('theme.'..conf.DEFAULT_COLOR_THEME..'.notification'),
	require('theme.'..conf.DEFAULT_COLOR_THEME..'.titlebar'),
	require('theme.'..conf.DEFAULT_COLOR_THEME..'.topbar'),
	require('theme.'..conf.DEFAULT_COLOR_THEME..'.colors')
)
-- table.insert(theme, require('theme.basic'))

theme.bg_other = '#232530'

theme.wallpaper = conf.WALLPAPER

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

theme.icon_theme = nil

theme.border_radius = dpi(6)
theme.titlebar_height = dpi(28)

theme.useless_gap   = dpi(8)

return theme

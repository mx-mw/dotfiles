local gfs = require('gears.filesystem')
local icons_path = gfs.get_configuration_dir()..'icons/'
local xresources = require('beautiful.xresources')
local gears = require('gears')

local dpi = xresources.apply_dpi
local theme = {}
-- You can use your own layout icons like this:
-- theme.layout_fairv = icons_path..'layouts/fairvw.png'
-- theme.layout_tile = icons_path..'layouts/tilew.png'
theme.systray_icon_spacing = dpi(8)
return theme
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local gfs = require('gears.filesystem')
local themes_path = gfs.get_configuration_dir() .. 'themes/'
local theme = {}

theme.font          = 'MesloLGS NF 8'

theme.bg_normal     = '#1C1E26'
theme.bg_focus      = '#1C1C24'
theme.bg_urgent     = '#1C1C24'
theme.bg_minimize   = '#1C1C24'
theme.bg_systray    = '#1C1C24'

theme.fg_normal     = '#aaaaaa'
theme.fg_focus      = '#ffffff'
theme.fg_urgent     = '#ffffff'
theme.fg_minimize   = '#ffffff'

theme.border_normal = '#0000003a'
theme.border_width  = dpi(0)
theme.border_focus  = '#535d6c'
theme.border_marked = '#91231c'

-- bar config
theme.bar_position = "top"
theme.bar_height = dpi(28)
theme.bar_item_radius = dpi(10)
theme.bar_item_padding = dpi(3)

theme.wallpaper_blur = themes_path.."blur.png"


return theme
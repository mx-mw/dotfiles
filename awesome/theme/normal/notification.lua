local xresources = require('beautiful.xresources')
local gears = require('gears')

local dpi = xresources.apply_dpi
local theme = {}

theme.notification_bg = '#1C1E26'
theme.notification_fg = '#ffffff'
-- theme.notification_height = dpi(10)
theme.notification_border_color = '#ed4e42'
theme.notification_width = dpi(300)
theme.notification_icon_size = dpi(70)
return theme
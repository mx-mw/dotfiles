local gfs = require('gears.filesystem')

local icon_path = gfs.get_configuration_dir() .. 'icons/'
local themes_path = gfs.get_themes_dir()
local theme = {}

-- regular
theme.titlebar_close_button_normal = icon_path..'titlebar/close/close_1.png'
theme.titlebar_close_button_focus = icon_path..'titlebar/close/close_2.png'
theme.titlebar_maximized_button_normal_inactive = icon_path..'titlebar/maximize/maximize_1.png'
theme.titlebar_maximized_button_focus_inactive  = icon_path..'titlebar/maximize/maximize_2.png'
theme.titlebar_maximized_button_normal_active = icon_path..'titlebar/maximize/maximize_3.png'
theme.titlebar_maximized_button_focus_active  = icon_path..'titlebar/maximize/maximize_3.png'
theme.titlebar_minimize_button_normal = icon_path..'titlebar/minimize/minimize_1.png'
theme.titlebar_minimize_button_focus  = icon_path..'titlebar/minimize/minimize_2.png'

-- hover
theme.titlebar_close_button_normal_hover = icon_path..'titlebar/close/close_3.png'
theme.titlebar_close_button_focus_hover = icon_path..'titlebar/close/close_3.png'
theme.titlebar_maximized_button_normal_inactive_hover = icon_path..'titlebar/maximize/maximize_3.png'
theme.titlebar_maximized_button_focus_inactive_hover  = icon_path..'titlebar/maximize/maximize_3.png'
theme.titlebar_maximized_button_normal_active_hover = icon_path..'titlebar/maximize/maximize_3.png'
theme.titlebar_maximized_button_focus_active_hover  = icon_path..'titlebar/maximize/maximize_3.png'
theme.titlebar_minimize_button_normal_hover = icon_path..'titlebar/minimize/minimize_3.png'
theme.titlebar_minimize_button_focus_hover  = icon_path..'titlebar/minimize/minimize_3.png'

return theme
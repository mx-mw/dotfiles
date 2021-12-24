local theme_assets = require('lib.beautiful.theme_assets')
local xresources = require('lib.beautiful.xresources')
local dpi = xresources.apply_dpi
local gfs = require('lib.gears.filesystem')
local themes_path = gfs.get_themes_dir()

local theme = {}
theme.taglist_bg_focus = '#F43E5C'
theme.taglist_bg_occupied = "#cdd4dd"
theme.taglist_bg_empty = "#cdd4dd"

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path..'default/submenu.png'
theme.menu_height = dpi(28)
theme.menu_width  = dpi(100)

return theme
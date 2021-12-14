local awful = require('awful')
local taglist_buttons = require('widgets.bottombar.taglist_buttons')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
return function (s)
	local mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		style   = {
			shape = gears.shape.circle
		},
		layout  = wibox.layout.fixed.horizontal,
		forced_height = 5,
		widget_template = {
			{
				left  = 12,
				right = 12,
				widget = wibox.container.margin
			},
			id     = 'background_role',
			widget = wibox.container.background
		},
		buttons = taglist_buttons
	}
	
	local margin = 5
    return wibox.widget {
        -- width = dpi(30000),
        wibox.container.margin(mytaglist, margin, margin, margin, margin),
        bg = beautiful.bg_normal,
        widget = wibox.container.background,
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
end

local wibox = require('wibox')
local gears = require('lib.gears')
local beautiful = require('lib.beautiful')
local borders = require('lib.borders')

return function(w, h)
	return borders(wibox.widget {
		{
			w,
			margins = 10,
			widget = wibox.container.margin 
		},
		shape = function(cr, width, height) 
			return gears.shape.rounded_rect(cr, width, height, 5)
		end,
		spacing = 10,
		bg = beautiful.bg_normal,
		widget = wibox.container.background,
		valign = 'left'
	}, 1000, h and h or 80, 5)
end
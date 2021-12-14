local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require('gears')
local row = require('widgets.sidebar.row')

local hours = wibox.widget.textclock()
hours.font = "MesloLGS NF 38"
hours.format = "%H"

local minutes = wibox.widget.textclock()
minutes.font = "MesloLGS NF 38"
minutes.format = "<span foreground='"..beautiful.red.."'>%M</span>"

local day = wibox.widget.textclock()
day.font = "MesloLGS NF 28"
day.format = "<span foreground='"..beautiful.red.."'>%e</span>"

local month = wibox.widget.textclock()
month.font = "MesloLGS NF 28"
-- month.format = "<span foreground='"..beautiful.red.."%m</span>"
month.format = ".<span foreground='"..beautiful.red.."'>%m</span>"

return {
	{
		wibox.widget {
		markup = "Hi. It's",
		widget = wibox.widget.textbox
		},
		{
			{
				hours, 
				minutes,
				spacing = 8, 
				layout = wibox.layout.align.horizontal,
			},
			-- {
			-- 	day,
			-- 	-- wibox.widget {
			-- 	-- 	markup = '/',
			-- 	-- 	widget = wibox.widget.textbox
			-- 	-- },
			-- 	month,
			-- 	layout = wibox.layout.align.horizontal
			-- },
			spacing = 25,
			layout = wibox.layout.fixed.horizontal
		},
		layout = wibox.layout.align.vertical
	},
	layout = wibox.layout.align.vertical
}
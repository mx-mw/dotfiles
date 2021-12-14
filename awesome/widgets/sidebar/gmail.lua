local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local count = wibox.widget {
    font = "MesloLGS NF 8",
    widget = wibox.widget.textbox
}
local icon_widget = wibox.widget {
	markup = ' ',
    font = "MesloLGS NF 32",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local weather_widget = wibox.widget {
	{layout = wibox.layout.fixed.horizontal},
    icon_widget,
    count, 
    spacing = 3,
    layout = wibox.layout.fixed.horizontal
}

local update_widget = function(widget, stdout, stderr)
    local num = string.match(string.match(stdout, "<fullcount>.+</fullcount>"), "%d+")
	count.markup = '<span foreground="'..beautiful.fg_normal..'">'..num..' unread</span>'
end
awful.widget.watch('/home/max/.config/awesome/widgets/sidebar/check_email.sh', 5000, update_widget, weather_widget)

return weather_widget
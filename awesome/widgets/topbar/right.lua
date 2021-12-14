local wibox = require('wibox')
local beautiful = require('beautiful')
local mytextclock = wibox.widget.textclock()
return function(s)   -- Right widgets
    return wibox.widget {
        mytextclock,
        require('widgets.topbar.layout')(s),
        require("widgets.topbar.mouse_off"),
        bg = beautiful.bg_normal,
        widget = wibox.container.background,
        -- expand = "none",
        layout = wibox.layout.align.horizontal
    }
end
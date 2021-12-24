local wibox = require('wibox')
local beautiful = require('lib.beautiful')
local mytextclock = wibox.widget.textclock()
return function(s)   -- Right widgets
    return wibox.widget {
        -- mytextclock,
        require('widgets.bottombar.layout')(s),
        require("widgets.bottombar.mouse_off"),
        bg = beautiful.bg_normal,
        widget = wibox.container.background,
        -- expand = "none",
        layout = wibox.layout.align.horizontal
    }
end
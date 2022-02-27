local awful = require('awful')
local wibox = require('wibox')

client.connect_signal("request::titlebars", function(c)
	local buttons = require('widget.titlebar.buttons')(c)
    awful.titlebar(c) : setup {
        nil,
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
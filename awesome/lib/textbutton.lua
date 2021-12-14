local wibox = require('wibox')
local beautiful = require('beautiful')
local awful = require('awful')
return function (text, onclick)
    local textbox = wibox.widget {
        markup  = "<span>" .. text .. "</span>",
        align   = "center",
        valign  = "center",
        widget  = wibox.widget.textbox,
        fgcolor = "#eeeeee"
    }
    local container = wibox.widget {
        textbox,
        widget = wibox.container.background,
		bg     = "#00000000",
    }

    container:connect_signal(
        "mouse::enter",
        function(c)
            textbox.markup = "<span fgalpha='80%'>" .. text .. "</span>"
            textbox.fgcolor = "#eeeeee"
        end
    )
    container:connect_signal(
        "mouse::leave",
        function(c)
            textbox.markup = "<span fgalpha='100%'>" .. text .. "</span>"
            textbox.fgcolor = "#eeeeee"
        end
    )
    container:connect_signal(
        "button::press",
        function(c)
            textbox.markup = "<span fgalpha='60%'>" .. text .. "</span>"
            textbox.fgcolor = "#eeeeee"
        end
    )
    container:connect_signal(
        "button::release",
        function(c)
            textbox.markup = "<span fgalpha='100%'>" .. text .. "</span>"
            textbox.fgcolor = "#eeeeee"

            onclick(container)
        end
    )

    return container
end

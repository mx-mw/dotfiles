local gears = require("lib.gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("lib.naughty")
local dpi = beautiful.xresources.apply_dpi
local apply_borders = require('lib.borders')
local button = require("lib.button") 

local create_shortcut = function(c, icon, location)
    local shortcut = button.create_text(beautiful.fg_normal .. "E6", beautiful.red, icon, "FiraMono Nerd Font 12", function()
        awful.spawn.with_shell("xdotool key ctrl+l; xdotool type --delay 0 "..location.."; xdotool key Return;")
    end)

    shortcut.forced_width = dpi(32)
    shortcut.forced_height = dpi(32)

    return shortcut
end
local get_widget = function(c)

    return wibox.widget {
        {
            {
                nil,
                {
                    nil,
                    {
                        create_shortcut(c, "", "/home/max"),
                        create_shortcut(c, "", "trash:///"),
                        -- create_shortcut(c, "", "/data"),
                        {
                            -- separator
                            bg = beautiful.transparent,
                            forced_height = dpi(1), 
                            widget = wibox.container.background
                        }, 
                        create_shortcut(c, "", "/home/max/Downloads"),
                        create_shortcut(c, "", "/home/max/Documents"),
                        create_shortcut(c, "", "/home/max/Pictures"),
                        create_shortcut(c, "", "/home/max/Video"),
                        spacing = dpi(10),
                        layout = wibox.layout.fixed.vertical
                    },
                    expand = "none",
                    layout = wibox.layout.align.horizontal
                },
                expand = "none", 
                layout = wibox.layout.align.vertical
            }, 
            bg = beautiful.bg_other,
			shape = function (cr, w, h)
				gears.shape.partially_rounded_rect(
					cr, w, h, 
					false,
					true,
					false,
					false,
					50
				)
			end,
            widget = wibox.container.background, 
        }, 
		
        left = dpi(2),
        widget = wibox.container.margin
    }
end

return get_widget
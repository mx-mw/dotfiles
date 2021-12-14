local awful = require("awful")
local wibox = require("wibox")
local beautiful = require('beautiful')

local shapes = require("lib.shapes")

local set_titlebar = function(c, right_border_img, client_color)
	awful.titlebar(c, { size = 2, position = "right", bg = "transparent" }) : setup {
		wibox.widget.imagebox(right_border_img, false),
        layout = wibox.layout.fixed.vertical,
    }
end

local left = function(c, args)
    local right_border_img = shapes.flip(
        shapes.create_edge_left {
            client_color = args.client_color,
            height = c.screen.geometry.height,
            stroke_offset_outer = 0.5,
            stroke_width_outer = 1,
            stroke_color_outer = args.stroke_color_outer_sides,
            stroke_offset_inner = 1.5,
            stroke_width_inner = 1.5,
            inner_stroke_color = args.stroke_color_inner_sides,
        }, "horizontal")

    set_titlebar(c, right_border_img, args.client_color)
end

return left
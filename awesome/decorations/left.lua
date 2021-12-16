-- --[[
    
-- Copyright (c) 2020 mut-ex <https://github.com/mut-ex>
-- The following code is a derivative work of the code from the awesome-wm-nice project 
-- (https://github.com/mut-ex/awesome-wm-nice/), which is licensed MIT. This code therefore 
-- is also licensed under the terms of the MIT License
-- ]]--

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require('beautiful')
local gears = require('gears')
local conf  = require('conf')
local shapes = require("lib.shapes")

local set_left_titlebar = function(c, left_border_img, client_color)

	awful.titlebar(c, { size = 2, position = "left", bg = "transparent" }) : setup {
		wibox.widget.imagebox(left_border_img, false),
        layout = wibox.layout.fixed.vertical,
    }
end

local set_thunar_left_titlebar = function(c, left_border_img)
    local custom_titlebar = require("decorations.thunar")(c)
	local buttons = gears.table.join(
		awful.button({ }, 1, function()
			c:emit_signal('request::activate', 'titlebar', {raise = true})
			awful.mouse.client.move(c)
		end),
		awful.button({ }, 3, function()
			c:emit_signal('request::activate', 'titlebar', {raise = true})
			awful.mouse.client.resize(c)
		end)
	)
    awful.titlebar(c, {
        position = "left",
        size = 48,
        bg = beautiful.bg_normal,
        widget = wibox.container.background,
    }):setup{
		buttons = buttons,
        custom_titlebar,
        bgimage = left_border_img,
        widget = wibox.container.background,
    }
end

local left = function(c, args)
    -- The left side border
    local left_border_img = shapes.create_edge_left {
        client_color = args.client_color,
        height = c.screen.geometry.height,
        stroke_offset_outer = 0.5,
        stroke_width_outer = 1,
        stroke_color_outer = args.stroke_color_outer_sides,
        stroke_offset_inner = 1.5,
        stroke_width_inner = 1.5,
        inner_stroke_color = args.stroke_color_inner_sides,
    }

    if c.class == "Thunar" and c.type == "normal" then
        set_thunar_left_titlebar(c, left_border_img)
	elseif conf.EDGES then
        set_left_titlebar(c, left_border_img, args.client_color)
    end

	collectgarbage("collect")
end

return left
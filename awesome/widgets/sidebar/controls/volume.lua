-- local gears      = require('gears')
-- local beautiful  = require('beautiful')
-- local xresources = require('beautiful.xresources')
-- local dpi        = xresources.apply_dpi
-- local wibox      = require('wibox')
-- local box        = require('lib.box')
-- local awful      = require('awful')

local INC_VOLUME_CMD = 'amixer -D pulse sset Master 5%+'
local DEC_VOLUME_CMD = 'amixer -D pulse sset Master 5%-'
local TOG_VOLUME_CMD = 'amixer -D pulse sset Master toggle'
local awful     = require("awful")
local watch     = require("awful.widget.watch")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local split     = require('lib.split')
local gears     = require("gears")
local borders = require('lib.borders')
local content = {}

local container = {}
local function createCpuMonitor(avg)
  --[[local detailText = math.floor(disk.used/1024/1024)
  .. '/'
  .. math.floor(disk.size/1024/1024) .. 'GB']]--
    local detailText = avg.." °C"
	local widget =  wibox.widget {
		        borders({
					id="subwidget",
					{
						id = "arcchart",
						min_value = 0, 
						max_value = 100, 
						value = avg,
						start_angle = 3 * math.pi / 2,
						bg = beautiful.misc2, 
						colors = { beautiful.purple },
						rounded_edge = true, 
						thickness = 10,
						widget = wibox.container.arcchart
					},        
					{
						markup = "<span foreground='"..beautiful.fg_dark.."'>"..''.."</span>",
						font = "MesloLGS NF 10", 
						align = "center",  
						widget = wibox.widget.textbox
					},
					forced_height = 54, 
					layout = wibox.layout.stack
		        }, 64, 60, 5), 
		        spacing = 8,
		        layout = wibox.layout.fixed.vertical
	}

	widget:connect_signal("button::press", function(_, _, _, button)
		if (button == 4) then 
			awful.spawn(INC_VOLUME_CMD, false)
		elseif (button == 5) then 
			awful.spawn(DEC_VOLUME_CMD, false)
		elseif (button == 1) then 
			awful.spawn(TOG_VOLUME_CMD, false)
		end
	end)
	return widget
end

local function worker(args)
    local mounts = {"/", "/data"}
    local timeout = 1
    local disks = {}

    content = wibox.layout.fixed.horizontal()
    content.spacing = 36

    container = wibox.widget {
      content, 
      spacing = 24, 
      layout = wibox.layout.fixed.horizontal
    }

    watch("get_vol", timeout,
        function(widget, stdout, stderr)
			local vol = string.match(stdout, "%d+%%"):gsub("%%", "")

            widget:reset(widget)
          
            widget:add(createCpuMonitor(tonumber(vol)))

        end,
        content
    )

    return container
end

return setmetatable(container, { __call = function(_, ...)
    return worker(...)
end })

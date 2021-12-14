local awful     = require("awful")
local watch     = require("awful.widget.watch")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local split     = require('lib.split')
local gears     = require("gears")
local borders = require('lib.borders')

local content = {}

local container = {}

local function createCpuMonitor(ram)
  --[[local detailText = math.floor(disk.used/1024/1024)
  .. '/'
  .. math.floor(disk.size/1024/1024) .. 'GB']]--
  	local detailText = math.floor((ram.size - ram.used)/1024/1024) .. " GB free"

    return wibox.widget{
        borders({
          {
            min_value = 0, 
            max_value = 100, 
            value = ram.perc,
            start_angle = 3 * math.pi / 2,
            bg = beautiful.misc2, 
            colors = { beautiful.green_light },
            rounded_edge = true, 
            thickness = 10,
            widget = wibox.container.arcchart
          },        
          {
            markup = "<span foreground='"..beautiful.fg_dark.."'></span>",
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
end

local function worker(args)
    local mounts = {"/", "/data"}
    local timeout = 60
    local disks = {}

    content = wibox.layout.fixed.horizontal()
    content.spacing = 36

    container = wibox.widget {
      content, 
      spacing = 24, 
      layout = wibox.layout.fixed.horizontal
    }

    watch([[bash -c "free | grep Mem:"]], timeout,
        function(widget, stdout)
			local spl  = split(stdout, ' ')
			local total = spl[2]
			local used = spl[3]
            widget:reset(widget)
          
            widget:add(createCpuMonitor({
				size = total,
				used = used,
				perc = math.floor(used / total * 100)
			}))

        end,
        content
    )

    return container
end

return setmetatable(container, { __call = function(_, ...)
    return worker(...)
end })

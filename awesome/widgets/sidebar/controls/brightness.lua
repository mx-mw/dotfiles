local gears      = require('lib.gears')
local beautiful  = require('lib.beautiful')
local xresources = require('lib.beautiful.xresources')
local dpi        = xresources.apply_dpi
local wibox      = require('wibox')
local box        = require('lib.box')
local awful      = require('lib.awful')
local borders = require('lib.borders')

local content = {}

local container = {}

local function createCpuMonitor(avg)
  --[[local detailText = math.floor(disk.used/1024/1024)
  .. '/'
  .. math.floor(disk.size/1024/1024) .. 'GB']]--
    local detailText = avg.."%"

	return wibox.widget {
		        
		        borders({
		          {
		            min_value = 0, 
		            max_value = 100, 
		            value = avg,
		            start_angle = 3 * math.pi / 2,
		            bg = beautiful.misc2, 
		            colors = { beautiful.green_light },
		            rounded_edge = true, 
		            thickness = 10,
		            widget = wibox.container.arcchart
		          },        
		          {
		            markup = "<span foreground='"..beautiful.fg_dark.."'>"..''.."</span>",
		            font = "MesloLGS NF 10", 
		            align = "center",  
		            widget = wibox.widget.textbox
		          },
		          forced_height = 54, 
		          layout = wibox.layout.stack
		        }, 64, 60, 5),
		        -- {
		        --   markup = "<span foreground='"..beautiful.fg_dark.."'>"..detailText.."</span>",
		        --   align = "center", 
		        --   font = "MesloLGS NF 9", 
		        --   widget = wibox.widget.textbox
		        -- }, 
		        spacing = 8,
		        layout = wibox.layout.fixed.vertical
	}
end

local function worker(args)
    local timeout = 60

    content = wibox.layout.fixed.horizontal()
    content.spacing = 36

    container = wibox.widget {
      content, 
      spacing = 24, 
      layout = wibox.layout.fixed.horizontal
    }

    content:add(createCpuMonitor(100))

    return container
end

return setmetatable(container, { __call = function(_, ...)
    return worker(...)
end })

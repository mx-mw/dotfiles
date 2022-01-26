local wibox = require('wibox')
local awful = require('lib.awful')
local xresources = require('lib.beautiful.xresources')
local rubato = require('rubato')
local row = require('widgets.sidebar.row')
local dpi = xresources.apply_dpi
local borders = require('lib.borders')
local conf = require('conf')
local gears = require('lib.gears')
--[[ Sidebar Construction ]]--

local dims = {
	height = awful.screen.focused().geometry.height,
	width  = dpi(400)
}

local sidebar = wibox({
	visible = true, 
    ontop = true, 
    type = "splash", 
	bg = '#1C1E26',
	y = 0,
	x = 4480-dims.width,
    width = dims.width,
    height = dims.height
})

local margin_size = 30

local container = wibox.container.margin()
container.margins = margin_size
container:setup {
	{
		conf.SIDEBAR.modules.clock         and row(require('widgets.sidebar.clock'),         98) or nil,
		conf.SIDEBAR.modules.spotify       and row(require('widgets.sidebar.spotify'),       80) or nil,
		conf.SIDEBAR.modules.controls      and row(require('widgets.sidebar.controls'),      90) or nil,
		conf.SIDEBAR.modules.monitor       and row(require('widgets.sidebar.monitor'),       90) or nil,
		conf.SIDEBAR.modules.weather       and row(require('widgets.sidebar.weather'),       75) or nil,
		conf.SIDEBAR.modules.notifications and row(require('widgets.sidebar.notifications'), 210)or nil,
			
		layout = wibox.layout.fixed.vertical,
		spacing = 30,
	},
	nil,
	conf.SIDEBAR.modules.system and row(require('widgets.sidebar.system'), 53) or nil,

	layout = wibox.layout.align.vertical,
	expand = "none",
	spacing = 30
}


sidebar:setup {
	borders(container, dims.width, dims.height, 5),
	widget = wibox.container.background
}

--[[ Animations ]]--

local timed = rubato.timed {
	intro = 0.05,
	duration = 0.15,
	rate = 100,
	easing = rubato.easing.quadratic
}

timed:subscribe(function (pos)
	sidebar.x = pos
end) 
timed.target = 4478
timed.target = 4478


--[[ Signals ]]--

sidebar:connect_signal('mouse::leave', function() 
	if(sidebar.x == 4480-dims.width) then 
		awesome.emit_signal('sidebar::toggle') 
	end
end)

sidebar:connect_signal('mouse::enter', function() 
	if(sidebar.x > 4470 and sidebar.x ~= 4478) then 
		awesome.emit_signal('sidebar::toggle') 
	end
end)

sidebar:connect_signal('button::release', function()
	if(sidebar.x == 4478) then
		awesome.emit_signal('sidebar::toggle') 
	end
end)

awesome.connect_signal('sidebar::toggle', function()
	if(timed.target == 4478) then
		timed.target = 4480-dims.width
	else
		timed.target = 4478

	end
end)


collectgarbage("collect")
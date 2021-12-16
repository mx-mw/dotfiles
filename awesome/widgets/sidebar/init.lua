local wibox = require('wibox')
local awful = require('awful')
local xresources = require('beautiful.xresources')
local rubato = require('rubato')
local row = require('widgets.sidebar.row')
local dpi = xresources.apply_dpi
local borders = require('lib.borders')

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
	row(require('widgets.sidebar.clock'),         98),
	row(require('widgets.sidebar.spotify'),       80),
	row(require('widgets.sidebar.controls'),      90),
	row(require('widgets.sidebar.monitor'),       90),
	row(require('widgets.sidebar.weather'),       75),
	row(require('widgets.sidebar.notifications'), 210),

	row(require('widgets.sidebar.system'),        53),


	layout = wibox.layout.fixed.vertical,
	expand = "none",
	spacing = 30
}

sidebar:setup {
	borders(container, dims.width, dims.height, 5),
	widget = wibox.container.background
}

--[[ Animations ]]--

-- local timed = rubato.timed {
-- 	intro = 0.05,
-- 	duration = 0.15,
-- 	rate = 100,
-- 	easing = rubato.easing.quadratic
-- }

-- timed:subscribe(function (pos)
-- 	sidebar.x = pos
-- end) 
-- timed.target = 4478
-- timed.target = 4478

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
sidebar.x = 4478
awesome.connect_signal('sidebar::toggle', function() 
	-- sidebar.visible = not sidebar.visible
	-- if(timed.target == 4478) then
	-- 	timed.target = 4480-dims.width
	-- else
	-- 	timed.target = 4478
	-- end
	if(sidebar.x == 4478) then
		sidebar.x = 4480-dims.width
	else
		sidebar.x = 4478
	end
end)

collectgarbage("collect")
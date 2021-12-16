local gears      = require('gears')
local beautiful  = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi        = xresources.apply_dpi
local wibox      = require('wibox')
local box        = require('lib.bottombar.dock_item')
local awful      = require('awful')

return wibox.widget {
	box(beautiful.red, '', function ()
		awesome.quit()
	end),
	box(beautiful.red, '', function ()
		awful.spawn 'poweroff'
	end),
	box(beautiful.red, 'ﰇ', function ()
		awful.spawn 'reboot'
	end),
	spacing = 70,
	layout = wibox.layout.fixed.horizontal
}
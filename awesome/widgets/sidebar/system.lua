local gears      = require('lib.gears')
local beautiful  = require('lib.beautiful')
local xresources = require('lib.beautiful.xresources')
local dpi        = xresources.apply_dpi
local wibox      = require('wibox')
local box        = require('lib.bottombar.dock_item')
local awful      = require('lib.awful')

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
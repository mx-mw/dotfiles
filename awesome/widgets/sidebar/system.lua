local gears      = require('gears')
local beautiful  = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi        = xresources.apply_dpi
local wibox      = require('wibox')
local box        = require('lib.bottombar.dock_item')
local awful      = require('awful')

local function createSystemButton(icon, cb) 
	local container = wibox.widget {
		markup = "<span foreground='"..beautiful.fg_normal.."' fgalpha='80%'> "..icon.." </span>",
		font   = "MesloLGS NF 14",
		align  = "center",
		valign = "center",
		widget = wibox.widget.textbox
	}

	local bg = wibox.widget {
		container,
		wiget = wibox.container.background
	}

	bg:connect_signal('mouse::enter', function ()
		bg.bg = beautiful.fg_bg
	end)
	bg:connect_signal('mouse::leave', function ()
		bg.bg = beautiful.transparent
	end)
	bg:connect_signal('mouse::release', function ()
		cb()
	end)

	return bg
end

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
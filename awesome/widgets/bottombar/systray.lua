local beautiful = require('beautiful')
local gears     = require('gears')
local awful     = require('awful')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox     = require('wibox')
return function () 
    local tray = wibox.widget.systray()
    
	local margin = 1

    return wibox.container.margin(tray, margin, margin+5, margin, margin)
end
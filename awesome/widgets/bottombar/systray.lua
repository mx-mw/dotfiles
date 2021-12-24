local beautiful = require('lib.beautiful')
local gears     = require('lib.gears')
local awful     = require('lib.awful')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox     = require('wibox')
return function () 
    local tray = wibox.widget.systray()
    
	local margin = 1

    return wibox.container.margin(tray, margin, margin+5, margin, margin)
end
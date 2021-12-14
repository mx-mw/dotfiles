local awful = require('awful')
local taglist_buttons = require('widgets.topbar.taglist_buttons')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
return function (s)
    -- Each screen has its own tag table.

    local mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    return wibox.widget {
        width = dpi(30000),
        mytaglist,
        bg = beautiful.bg_normal,
        widget = wibox.container.background,
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
end

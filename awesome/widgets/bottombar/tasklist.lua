local beautiful  = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi        = xresources.apply_dpi
local awful      = require('awful')
local wibox      = require('wibox')
local tasklist_buttons = require('widgets.bottombar.tasklist_buttons')
local gears          = require('gears')

return function (s)
    local mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        halign    = 'center',
		height = dpi(15),
        layout   = {
            spacing_widget = {
                {
                    forced_width  = 5,
                    forced_height = 24,
                    thickness     = 0,
                    color         = '#777777',
                    widget        = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            halign = 'center',
            spacing = 1,
            layout  = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = 5,
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 5,
                widget  = wibox.container.margin
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.horizontal,
        },
    }
    mytasklist.visible = false

    local inactive = '    '
    local active = '   '
    local current = inactive
    local tray_toggle = wibox.widget{
        markup = '<span>'..current..'</span>',
        align  = 'center',
        font   = 'MesloLGS NF 5',
        valign = 'center',
        widget = wibox.widget.textbox,
        fgcolor = "#eeeeee"
    }
    local container = wibox.widget {
        tray_toggle,
        widget = wibox.container.background,
        bg = beautiful.bg_normal
    }

    container:connect_signal('mouse::enter', function (c)
        tray_toggle.markup = '<span fgalpha=\'80%\'>'..current..'</span>'
        tray_toggle.fgcolor = "#eeeeee"
    end)
    container:connect_signal('mouse::leave', function (c)
        tray_toggle.markup = '<span fgalpha=\'100%\'>'..current..'</span>'
        tray_toggle.fgcolor = "#eeeeee"

    end)
    container:connect_signal('button::press', function (c)
        tray_toggle.markup = '<span fgalpha=\'60%\'>'..current..'</span>'
        tray_toggle.fgcolor = "#eeeeee"
    end)
    container:connect_signal('button::release', function (c)
        if current == active then
            current = inactive
            mytasklist.visible = false
        else
            current = active
            mytasklist.visible = true
        end
        tray_toggle.markup = '<span fgalpha=\'100%\'>'..current..'</span>'
        tray_toggle.fgcolor = "#eeeeee"

        awful.spawn.with_shell('polychromatic-cli -n "Razer DeathAdder Elite" -o brightness -p 0')
    end)

    awesome.connect_signal("tasklist::hide", function()
        mytasklist.visible = false
        container:emit_signal('button::releas')
    end)
    
    return wibox.widget {
        container,
        mytasklist,
        nil,
        layout = wibox.layout.fixed.horizontal,
        align = 'center',
        expand = 'none',
        bg = beautiful.bg_normal,
        height = dpi(10),
        shape = function(cr, width, height) 
            gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, 10)
        end
    }
end
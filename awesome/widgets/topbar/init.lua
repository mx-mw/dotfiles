local gears = require('lib.gears')
local awful = require('lib.awful')
local wibox = require('wibox')
local beautiful = require('lib.beautiful')

awful.screen.connect_for_each_screen(function(s)
    local home = '  '
    local occupied = '  '
    local unoccupied = '  '
    awful.tag({ home, occupied, occupied, occupied, occupied, occupied }, s, awful.layout.layouts[1])
    
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    local spotify = require('widgets.topbar.spotify')
    gears.timer {
        timeout   = 3,
        call_now  = true,
        autostart = true,
        callback  = function ()
            awful.spawn.easy_async_with_shell('sp current', function(out) 
                if string.match(out, "Error: Spotify is not running.") then 
                    spotify.visible = false
                else
                    spotify.visible = true
                end
            end)
        end
    }
    -- Create the wibox
    s.mywibox = awful.wibar { position = 'top', 
        ontop = false,
        screen = s,
        -- height = dpi(30),
        -- width = dpi(350),
        bg = '#00000000',
        align = 'center',
        restrict_workarea = false,
        layout = wibox.layout.fixed.horizontal,
        widget = wibox.widget {
            layout = wibox.layout.align.horizontal,
            {
                bg = beautiful.bg_normal,
                require('widgets.topbar.left')(s),
                shape_clip = true,
                shape = function(cr, width, height) 
                    gears.shape.partially_rounded_rect(cr, width, height, false, false, true, false, 10)
                end,
                widget = wibox.container.background,
                
            },
            {
                bg = beautiful.bg_normal,
                spotify,
                shape_clip = true,
                shape = function(cr, width, height) 
                    gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, 10)
                end,
                widget = wibox.container.background,
                
            }, -- Middle widget
            {
                bg = beautiful.bg_normal,
                require('widgets.topbar.right')(s),
                shape_clip = true,
                shape = function(cr, width, height) 
                    gears.shape.partially_rounded_rect(cr, width, height, false, false, false, true, 10)
                end,
                widget = wibox.container.background,
                
            },
        expand = 'none',

        }
    }

    awesome.connect_signal('topbar::show', function ()
        s.mywibox.visible = true
    end)

    awesome.connect_signal('topbar::hide', function ()
        s.mywibox.visible = false
    end)
end)
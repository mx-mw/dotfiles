local xresources       = require('beautiful.xresources')
local gears            = require('gears')
local borders          = require('lib.borders')
local conf             = require('conf')
local dpi              = xresources.apply_dpi
local awful            = require('awful')
local wibox            = require('wibox')
local beautiful        = require('beautiful')


awful.screen.connect_for_each_screen(function(s)
	local home = '  '
    local occupied = '  '
    local unoccupied = '  '
    awful.tag({ '0', '1', '2', '3', '4', '5'}, s, awful.layout.layouts[1])
	s.mypromptbox = awful.widget.prompt()
    local spotify = require('widgets.bottombar.spotify')
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

    local dock = awful.wibar {
        ontop = false,
        position = 'bottom',
        screen = s,
        height = dpi(30),
        width = s.geometry.width - beautiful.useless_gap * 4,
        bg = '#1C1E26',
        align = 'centered',
        restrict_workarea = false,
        layout = wibox.layout.fixed.horizontal,
        widget = borders(wibox.widget {
			{
				layout = wibox.layout.fixed.horizontal,
				
				{
					bg = beautiful.bg_normal,
					require('widgets.bottombar.left')(s),
					shape_clip = true,
					shape = function(cr, width, height) 
						gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, 10)
					end,
					widget = wibox.container.background,
					
				},
			},
			{
					bg = beautiful.bg_normal,
					require('widgets.bottombar.dock'),
					shape_clip = true,
					shape = function(cr, width, height) 
						gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, 10)
					end,
					widget = wibox.container.background,
					
			},
             -- Middle widget
			{
				bg = beautiful.bg_normal,
				nil,
				{
					conf.SYSTRAY and require('widgets.bottombar.systray')() or nil,
					layout = wibox.layout.align.horizontal
		
				},
				height = dpi(25),
				shape_clip = true,
				shape = function(cr, width, height) 
					gears.shape.partially_rounded_rect(cr, width, height, true, false, false, false, 10)
				end,
				widget = wibox.container.background,
				
			},
            wibox.widget {
                markup = '  ',
                widget = wibox.widget.textbox,
            },
            expand = 'none',
            layout = wibox.layout.align.horizontal
        }, s.geometry.width - beautiful.useless_gap * 4, dpi(30), 5)
    }

    awesome.connect_signal('bottombar::hide', function() 
        dock.visible = false
    end)
    awesome.connect_signal('bottombar::show', function() 
        dock.visible = true
    end)
    s.dock = dock
end)
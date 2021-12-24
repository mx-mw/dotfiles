local wibox      = require("wibox")
local awful      = require("awful")
local gears      = require("gears")
local beautiful  = require("beautiful")
local textbutton = require("lib.textbutton")
local xresources = require('lib.beautiful.xresources')
local dpi        = xresources.apply_dpi
local watch      = require("awful.widget.watch")
local box        = require('lib.box')
local row        = require('widgets.sidebar.row')
----------------------
-- Spotify commands --
----------------------

local spotify_commands = {}
spotify_commands.status = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus'|egrep -A 1 \"string\"|cut -b 26-|cut -d '\"' -f 1|egrep -v ^$"
spotify_commands.song = "sp eval | grep SPOTIFY_TITLE"
spotify_commands.artist = "sp eval | grep SPOTIFY_ARTIST"
spotify_commands.toggle = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
spotify_commands.isrunning = "sp current"
-- spotify_commands.song = "sp eval | grep SPOTIFY_TITLE | sed 's|SPOTIFY_TITLE=\"||g' | sed 's|\"$||g'"
-- spotify_commands.artist = "sp eval | grep SPOTIFY_ARTIST | sed 's|SPOTIFY_ARTIST=\"||g' | sed 's|\"$||g'"
spotify_commands.prev = "sp prev"
spotify_commands.next = "sp next"



local function toggle()
    awful.spawn.with_shell(spotify_commands.toggle)
end

local paused  = "<span>" .. '    ' .. "</span>"
local playing = "<span>" .. '    ' .. "</span>"
local state = paused
local textbox = wibox.widget {
    markup  = state,
    align   = "center",
    valign  = "center",
    widget  = wibox.widget.textbox,
    fgcolor = "#eeeeee"
}
local function get_state()
    awful.spawn.easy_async_with_shell(spotify_commands.status, function(out) 
        if string.match(out, "Playing") then
            state = playing
            textbox.markup = playing
        elseif string.match(out, "Paused") then
            state = paused
            textbox.markup = paused

        else
            textbox.markup = paused
            state = paused
        end
    end)
end
get_state()


local container =
    wibox.widget {
    textbox,
    widget = wibox.container.background,
	bg     = "#00000000",

}

container:connect_signal(
    "mouse::enter",
    function(c)
        textbox.markup = "<span fgalpha='80%'>" .. state .. "</span>"
        get_state()
        textbox.fgcolor = "#eeeeee"
    end
)
container:connect_signal(
    "mouse::leave",
    function(c)
        textbox.markup = "<span fgalpha='100%'>" .. state .. "</span>"
        get_state()
        textbox.fgcolor = "#eeeeee"
    end
)
container:connect_signal(
    "button::press",
    function(c)
        textbox.markup = "<span fgalpha='60%'>" .. state .. "</span>"
        get_state()
        textbox.fgcolor = "#eeeeee"
    end
)
container:connect_signal(
    "button::release",
    function(c)
        textbox.markup = "<span fgalpha='100%'>" .. state .. "</span>"
        textbox.fgcolor = "#eeeeee"
        
        toggle()
        get_state()
    end
)

local spotify_widget = wibox.widget {
	nil,
	{
		textbutton('  寧  ', function(...) 
			awful.spawn.with_shell(spotify_commands.prev)
		end),

		container,

		textbutton('  嶺  ', function(...) 
			awful.spawn.with_shell(spotify_commands.next)
		end),
		bg     = "#00000000",
		layout = wibox.layout.align.horizontal,
	},
	spacing = dpi(8),
	valign = 'center',
    expand = 'none',
	bg     = "#00000000",
    layout = wibox.layout.align.horizontal,
    widget = wibox.container.background,
}

local coversize = 50

local art_container = wibox.widget {
	image = gears.surface.load_uncached('/tmp/spcover.png'),
	widget = wibox.widget.imagebox,
	-- clip_shape = true,
	forced_width = coversize,
	forced_height = coversize,
}
local prev = ''
awful.spawn.easy_async_with_shell('sp current', function(out) 
	prev = out
end)

local song = wibox.widget{
	markup = "<span foreground='"..beautiful.red_light.."'></span>",
	align  = 'center',
	valign = 'center',
	widget = wibox.widget.textbox
}

local artist = wibox.widget {
	markup = "<span foreground='".."#aaa".."'></span>",
	align  = 'center',

	valign = 'center',
	widget = wibox.widget.textbox
}

local song_info = wibox.widget {
	song,
	artist,
	layout = wibox.layout.align.vertical
}

gears.timer {
    timeout   = 2,
    call_now  = true,
    autostart = true,
    callback  = function ()
        get_state()
		awful.spawn.easy_async_with_shell('sp current', function(out) 
			if(out == prev) then return end
			prev = out
			awful.spawn.easy_async_with_shell('wget $(sp art) -O /tmp/spcover.png', function()
				art_container.image = gears.surface.load_uncached('/tmp/spcover.png')
			end)	
		end)
    end
}
watch(spotify_commands.song, 1, function(widget, out, a, b, c) 
	-- its ugly, and I am ashamed, but it works
	widget.markup = "<span foreground='"..beautiful.red_light.."'> "..string.match(string.match(out, '".+"'), '([a-zA-Z0-9 ,-.]+)').." </span>"
	collectgarbage("collect")
end, song)

watch(spotify_commands.artist, 1, function(widget, out, a, b, c) 
	-- its ugly, and I am ashamed, but it works
	local with_quotes = string.match(out, '".+"')
	if(with_quotes == nil) then return end
	widget.markup = "<span foreground='".."#aaa".."'> "..string.match(with_quotes, '([a-zA-Z0-9 ,-.]+)').." </span>"
	collectgarbage("collect")
end, artist)

return  {
	-- wibox.widget {
	-- 	markup = "You're listening to",
	-- 	widget = wibox.widget.textbox
	-- },
	{
		wibox.widget {
			art_container,
			shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, 5)
			end,
			clip_shape = true,
			widget = wibox.container.background
		},
		{
			song_info,
			spotify_widget,
			-- require('widgets.sidebar.controls.volume'),
			layout = wibox.layout.align.vertical
		},
		spacing = 10,
		layout = wibox.layout.fixed.horizontal
	},
	spacing = 10,
	layout = wibox.layout.fixed.vertical
}

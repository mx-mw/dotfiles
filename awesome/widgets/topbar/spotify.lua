local wibox = require("wibox")
local awful = require("awful")
local gears = require("lib.gears")

local beautiful = require("beautiful")
local textbutton= require("lib.textbutton")
local xresources = require('lib.beautiful.xresources')
local dpi = xresources.apply_dpi
----------------------
-- Spotify commands --
----------------------

local spotify_commands = {}
spotify_commands.status = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus'|egrep -A 1 \"string\"|cut -b 26-|cut -d '\"' -f 1|egrep -v ^$"
--spotify_commands.song = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 \"title\"|egrep -v \"title\"|cut -b 44-|cut -d '\"' -f 1|egrep -v ^$"
--spotify_commands.artist = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 \"artist\"|egrep -v \"artist\"|egrep -v \"array\"|cut -b 27-|cut -d '\"' -f 1|egrep -v ^$"
spotify_commands.toggle = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
spotify_commands.isrunning = "sp current"
spotify_commands.song = "sp eval | grep SPOTIFY_TITLE | sed 's|SPOTIFY_TITLE=\"||g' | sed 's|\"$||g'"
spotify_commands.artist = "sp eval | grep SPOTIFY_ARTIST | sed 's|SPOTIFY_ARTIST=\"||g' | sed 's|\"$||g'"
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
    bg = beautiful.bg_normal
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
        nil,
        {
            textbutton('  寧  ', function(...) 
                awful.spawn.with_shell(spotify_commands.prev)
            end),
            container,
            textbutton('  嶺  ', function(...) 
                awful.spawn.with_shell(spotify_commands.next)
            end),
            layout = wibox.layout.align.horizontal,
            spacing = dpi(8),
            valign = 'center'
        },
        bg = beautiful.bg_normal,
        layout = wibox.layout.align.horizontal,
    },
    expand = 'none',
    layout = wibox.layout.align.horizontal,
    widget = wibox.container.background,
}
gears.timer {
    timeout   = 2,
    call_now  = true,
    autostart = true,
    callback  = function ()
        get_state()
    end
}


return spotify_widget
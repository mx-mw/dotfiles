local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local json = require("lib.json")

local OPEN_WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?q=Sydney&units=metric&appid="

local get_command = function(api_key)
    return "curl -X GET '"..OPEN_WEATHER_URL..api_key.."'"
end

local get_icon = function(condition)
    local icon

    if (condition == "Thunderstorm") then
        icon = "<span foreground='"..beautiful.fg_normal.."'>".."朗 ".."</span>"
    elseif (condition == "Drizzle") then
        icon = "<span foreground='"..beautiful.fg_normal.."'>".."殺 ".."</span>"
    elseif (condition == "Rain") then
        icon = "<span foreground='"..beautiful.fg_normal.."'>".."歹 ".."</span>"
    elseif (condition == "Snow") then
        icon = "流 "
    elseif (condition == "Clear") then
        local time = os.date("*t")
        if time.hour > 6 and time.hour < 18 then
            icon = "<span foreground='"..beautiful.fg_normal.."'>".."滛 ".."</span>"
        else
            icon = "望 "
        end
    elseif (condition == "Clouds") then
        icon = "摒 "
    else
        icon = "敖 "
    end

    return icon
end

local temperature = wibox.widget {
    font = "MesloLGS NF 8",
    widget = wibox.widget.textbox
}

local description = wibox.widget {
    font = "MesloLGS NF 6", 
    widget = wibox.widget.textbox
}

local icon_widget = wibox.widget {
    font = "MesloLGS NF 32",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local weather_widget = wibox.widget {
    icon_widget,
    {
		nil, 
        {
            temperature,
            description,
            layout = wibox.layout.fixed.vertical
        }, 
        expand = "none", 
        layout = wibox.layout.align.vertical
    },
    spacing = 0,
    layout = wibox.layout.fixed.horizontal
}

local function getColorFromTemp(temp)
	return beautiful.red_light
	-- if(temp > 30) then 
	-- 	return beautiful.red_light
	-- elseif(temp > 20 and temp <= 30) then
	-- 	return beautiful.yellow
	-- elseif(temp > 10 and temp <= 20) then
	-- 	return beautiful.green_light
	-- else
	-- 	return beautiful.cyan_light
	-- end
end

local update_widget = function(widget, stdout, stderr)
    local result = json.decode(stdout)
    temperature.markup = "<span foreground='"..getColorFromTemp(result.main.temp).."'>"..tostring(result.main.temp).." °C</span>"
    description.markup = "<span foreground='"..beautiful.fg_normal.."'>"..result.weather[1].description.."</span>" 
    
    local condition = result.weather[1].main
    local icon = get_icon(condition)

    icon_widget.markup = icon
end



local api_key_path = awful.util.getdir("config") .. "widgets/sidebar/weather/api.key"
awful.spawn.easy_async_with_shell("cat "..api_key_path, function(stdout)
    local api_key = stdout:gsub("\n", "")
    -- wait for wifi to connect
    awful.spawn.easy_async_with_shell("sleep 1", function()
        awful.widget.watch(get_command(api_key), 5000, update_widget, weather_widget)
    end)
end)

return weather_widget
local awful = require('awful')
local gears = require('gears')
function split (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

local parse = function (stdout, stderr, reason, exit_code)
    local lines = split(stdout, '\n')
    local sink = ''
    for i, v in ipairs(lines) do
        if v == "	Active Port: analog-output-headphones" then
            sink = lines[i-49]
        end
    end
    
    local sink_id = string.sub(sink, 7)
    
    awful.spawn('pactl set-default-sink '..sink_id)
end

awful.spawn.easy_async('pactl list sinks', parse)


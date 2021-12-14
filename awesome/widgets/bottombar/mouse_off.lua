local textbutton = require('lib.textbutton')
local awful = require('awful')
local inactive = "    "
return textbutton(inactive, function(_) 
    awful.spawn.with_shell('polychromatic-cli -n "Razer DeathAdder Elite" -o brightness -p 0') 
end)

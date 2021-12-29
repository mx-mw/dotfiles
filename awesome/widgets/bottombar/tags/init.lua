local wibox = require 'lib.wibox'
local awful = require 'lib.awful'
return function(s)
	require('widgets.bottombar.tags.taglist')(s)
	return wibox.widget {
		require('lib.hamburger')(
				awful.button(
					{}, 
					1, 
					function()
						awesome.emit_signal('taglist::toggle')
					end)
			),
		widget = wibox.container.background
	}
end
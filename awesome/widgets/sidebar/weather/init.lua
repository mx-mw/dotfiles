local wibox = require('wibox')

return {
	{
		require('widgets.sidebar.weather.current'),
		layout = wibox.layout.fixed.vertical
	},
	{
		require('widgets.sidebar.weather.forecast'),
		layout = wibox.layout.fixed.vertical
	},
	spacing = 20,
	layout = wibox.layout.fixed.horizontal
}
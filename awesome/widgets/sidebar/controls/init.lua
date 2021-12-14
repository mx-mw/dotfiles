local wibox = require('wibox')

return {
	require('widgets.sidebar.controls.temp')(),
	require('widgets.sidebar.controls.volume')(),
	require('widgets.sidebar.controls.brightness')(),
	spacing = 40,
	layout = wibox.layout.fixed.horizontal
}
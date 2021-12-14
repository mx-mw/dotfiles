local wibox = require('wibox')

return {
	require('widgets.sidebar.monitor.disk')(),
	require('widgets.sidebar.monitor.cpu')(),
	require('widgets.sidebar.monitor.ram')(),
	spacing = 40,
	layout = wibox.layout.fixed.horizontal
}
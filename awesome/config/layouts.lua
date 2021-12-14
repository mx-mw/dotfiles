local awful = require('awful')

tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
		awful.layout.suit.tile,
		awful.layout.suit.fair,
		awful.layout.suit.floating,
	})
end)
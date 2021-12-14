local gears = require('gears')
local awful = require('awful')

return function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

	c.shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 5)
	end

end
local gears = require('lib.gears')
local awful = require('lib.awful')
local wibox = require('wibox')
local dump = require('lib.dump')
client.connect_signal('request::titlebars', function(c)
	-- if(c.class == "Code") then return end
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal('request::activate', 'titlebar', {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal('request::activate', 'titlebar', {raise = true})
            awful.mouse.client.resize(c)
        end)
    )
	-- if(c.class == "Thunar") then return end
    awful.titlebar(c, {bg_normal = '#1C1E26', bg_focus = '#1C1E26'}) : setup {
        -- { -- Left
        --     -- awful.titlebar.widget.iconwidget(c),
        --     buttons = buttons,
        --     layout  = wibox.layout.fixed.horizontal
        -- },
        -- { -- Middle
        --     buttons = buttons,
        --     layout  = wibox.layout.flex.horizontal
        -- },
        -- { -- Right
        --     -- awful.titlebar.widget.floatingbutton (c),
        --     awful.titlebar.widget.maximizedbutton(c),
        --     awful.titlebar.widget.minimizebutton(c),
        --     -- awful.titlebar.widget.stickybutton   (c),
        --     -- awful.titlebar.widget.ontopbutton    (c),
        --     awful.titlebar.widget.closebutton    (c),
        --     layout = wibox.layout.fixed.horizontal()
        -- },
        layout = wibox.layout.align.horizontal
    }
end)
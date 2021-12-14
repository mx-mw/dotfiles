local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local size = 40
local radius = 8
local clientIsApp = function(app, c)
    -- returns if the client c is the same as the sidebarbox-app (e.g. firefox, kitty, ...) 
    -- some fiddling needed, is kinda hacky
    if type(app) == "string" then
        if app == "intellij-idea-ultimate-edition" and c.class == "jetbrains-idea" then
            -- hmm
            return true
        elseif c.class ~= nil then
            return string.lower(c.class) == string.lower(app)
        elseif c.instance ~= nil then
            return string.lower(c.instance) == string.lower(app)
        elseif c.name ~= nil then
            return string.lower(c.name) == string.lower(app)
        else
            return false
        end
    end
end
local countIndicator = function()
    return wibox.widget {
        bg = beautiful.fg_normal,
        shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, dpi(50))
        end,
        forced_height = dpi(6),
        widget = wibox.container.background
    }
end

return function(fg, text, app, onclick, fontsize)
    local count = 0
	local open = false
    local countWidget = wibox.layout.fixed.horizontal()
    countWidget.forced_height = dpi(5)
    countWidget.spacing = dpi(2)
    
    
    
    local textbox = wibox.widget {
        markup = "<span foreground='"..fg.."' fgalpha='80%'>"..text.."</span>",
        font = "MesloLGS NF "..tostring(fontsize or 15),
        align = "center",
        valign = "center",
        forced_width = dpi(size), 
        forced_height = dpi(size - (2 * radius)), 
        widget = wibox.widget.textbox
    }

    local container = wibox.widget {
        textbox,
        bg = "#11111100", 
		shape = function(cr, width, height) 
			return gears.shape.rounded_rect(cr, width, height, 5)
		end,
        widget = wibox.container.background
    }

    local old_cursor, old_wibox
    container:connect_signal("mouse::enter", function()
        textbox.markup = "<span foreground='"..fg.."'>"..text.."</span>"
        -- textbox.font = "MesloLGS NF 18"
		container.bg = "#11111160"
        -- change cursor
        local wb = mouse.current_wibox
        old_cursor, old_wibox = wb.cursor, wb
        wb.cursor = "hand2" 
    end)

    container:connect_signal("mouse::leave", function()
		
        textbox.markup = "<span foreground='"..fg.."' fgalpha='80%'>"..text.."</span>"
        -- textbox.font = "MesloLGS NF 15" 
		-- reset cursor
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
		if open then
			return
		end
		container.bg = "#11111100"
        
    end)
    container:connect_signal('button::release', function(c)
        if type(app) == "string" then
            awful.spawn(app)
		gears.debug.print_warning("release")

        elseif type(app) == "function" then
            app()
        end

		onclick()
    end)
	local margin = wibox.container.margin()
	margin.margins = 2
	margin.left = 4
	margin.right = 4

	margin:setup {
		container,
		layout = wibox.layout.fixed.vertical,
		expand = "none",
	}

	-- client.connect_signal("manage", function(c)
    --     if clientIsApp(app, c) then
	-- 		count = count + 1
	-- 		if count < 6 then
    --             countWidget:insert(1, countIndicator())
    --         end
	-- 		open = true
    --         container.bg = "#11111180"
    --     end
    -- end)

    -- client.connect_signal("unmanage", function(c)
	-- 	gears.debug.print_warning(c.name)
    --     if clientIsApp(app, c) then
	-- 		count = count - 1
	-- 		open = false
	-- 		container.bg = "#11111100"
	-- 		if count < 5 then
    --             countWidget:remove(1)
    --         end
    --     end
    -- end)

    return wibox.widget {
        {
            margin,
			countWidget,
            layout = wibox.layout.fixed.vertical
        },
        spacing = dpi(2),
        layout = wibox.layout.fixed.horizontal
    }
end


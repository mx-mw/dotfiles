local awful = require('lib.awful')
local gears = require('lib.gears')


return function(s)
    local mylayoutbox = awful.widget.layoutbox(s)
    mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )
    )

    return mylayoutbox
end
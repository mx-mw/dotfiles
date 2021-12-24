local gears = require('lib.gears')
local awful = require('lib.awful')

return gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)
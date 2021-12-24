local beautiful     = require("beautiful")
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi
local gears         = require('lib.gears')
local wibox         = require("wibox")
local Apps          = require('config.apps')
local item          = require("lib.bottombar.dock_item")
local browser       = item(beautiful.yellow, "", Apps.browser)
local file_explorer = item(beautiful.purple, "", Apps.file_explorer)
local terminal      = item(beautiful.cyan, "", Apps.terminal)
local editor        = item(beautiful.blue, "﬏", Apps.editor)
local email         = item(beautiful.red, "", Apps.email)
local music         = item(beautiful.green, "阮", Apps.music)
local discord       = item(beautiful.blurple_light, "ﭮ", Apps.discord)
local notion        = item(beautiful.cyan, '', Apps.browser..' https://notion.so')

return wibox.widget {
    {
        editor,
        browser,
        file_explorer,
        terminal,
        email,
        music,
        discord,
        notion,
        spacing = dpi(8),
        layout = wibox.layout.fixed.horizontal
    },
    height = dpi(40),
    bg = beautiful.bg_normal,
    widget = wibox.container.background,
    expand = "none",
    layout = wibox.layout.align.horizontal,
    -- shape  = function(cr, width, height) 
    --     gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, 10)
    -- end
}

local naughty = require('lib.naughty')

-- 🚫 Handle Errors 🚫 --
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = 'Oops, there were errors during startup!',
                     text = awesome.startup_errors })
end

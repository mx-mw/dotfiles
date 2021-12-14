local conf = require('conf')

require('widgets.bottombar')
if(conf.SIDEBAR) then require('widgets.sidebar') end
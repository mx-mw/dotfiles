local conf = require('conf')

require('widgets.bottombar')
if conf.SIDEBAR.enabled then require('widgets.sidebar') end
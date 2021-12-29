local row = require('widgets.sidebar.row')
local wibox = require('wibox')
local naughty = require('lib.naughty')
local rubato = require('rubato')
local box = require('lib.bottombar.dock_item')
local beautiful = require("beautiful")
local debug = require('gears.debug')
local print = debug.print_warning
local content = wibox.layout.fixed.vertical()
content.spacing = 10
content.overflow = 'clip'

Queue = {
	queue = {}
}

function Queue:new(q)
	q = q or {}

	setmetatable(q, self)
	self.__index = self
	self.queue = {}
	self.update_cb = function () end
	return q
end

function Queue:add(i)
	table.insert(self.queue, 1, {
		item = i,
		index = 1
	})

	self.update_cb()
end

function Queue:del(index)
	local notif = self.queue[index or #self.queue]
	local timed = rubato.timed {
		duration = 0.5,
		intro    = 0.05,
		rate     = 10,
		subscribed = function(opa)
			notif.item.opacity = 100 - opa
			self.update_cb()
			if opa == 100 then
				table.remove(self.queue, index or #self.queue)
				for i, _ in ipairs(self.queue) do
					self.queue[i].index = i
				end
				self.update_cb()
			end
		end
	}
	timed.target = 100
	
end

function Queue:find(item)
	local index = -1

	for i, v in ipairs(self.queue) do
		if(v.item == item) then
			index = i
			break
		end
	end

	self.update_cb()
	return index
end

function Queue:move(from, to)
	a = self.queue[from]
	table.remove(self.queue)
	table.insert(self.queue, to, a)

	self.update_cb()
end

function Queue:apply_cb(cb)

	self.update_cb = cb
end

local notifications = Queue:new()

notifications:apply_cb(function (...)
	content:reset(content)
	for i, v in ipairs(notifications.queue) do
		local widget = wibox.widget {
			{
				{
					wibox.widget {
						image = v.item.icon,
						widget = wibox.widget.imagebox
					},
					{
						valign = 'centered',
						wibox.widget {
							markup = '<span weight="bold" foreground="'..beautiful.red..'">'..v.item.title..'</span>',
							widget = wibox.widget.textbox
						},
						wibox.widget {
							markup = '<span weight="normal">'..v.item.text..'</span>',
							widget = wibox.widget.textbox
						},
						layout = wibox.layout.fixed.vertical
					},
					valign = 'center',
					layout = wibox.layout.fixed.horizontal,
					forced_width = 230,
					spacing = 10
				},
				box(beautiful.red, '', '', function(...)
					notifications:del(i)
				end, 8),
				forced_height = 18,
				spacing = 10,
				layout = wibox.layout.fixed.horizontal
			},
			opacity = v.item.opacity or 100,
			bg = beautiful.bg_normal,
			widget = wibox.container.background
		}
		content:add(row(widget))
		collectgarbage("collect")
	end
end)

naughty.connect_signal('added', function(notification)
	notifications:add(notification)
end)

local container = wibox.widget {
	content, 
	forced_height = 190,
	spacing = 24, 
	layout = wibox.layout.fixed.horizontal
}
return container
local class = require 'middleclass'
local GUI = {}

local Base = class('GuiBase')

function Base:initialize(type, id)
  self.type = type
  self.id = id
  self.active = false
end

function Base:draw(x, y) end

function Base:pressed(btn) end -- event based so i wont call update for every gui element

function Base:hover(active) end -- called when hover started with active being true and ended with active false

function Base:update(dt) end -- updating only when element active

local Panel = class('GuiPanel', Base) -- any gui element must be in a Panel

function Panel:initialize(id, w, h)
  Base.initialize(self, 0, id)
  self.w = w
  self.h = h
  self.subelem = {} -- a table containing all of the subelements MUST BE INSTANCE OF GuiBase CLASS
end

function Panel:draw(x, y)
  love.graphics.rectangle('line', x, y, x+self.w, y+self.h)
end

function Panel:update(dt)

end

local Text = class('GuiText', Base)

function Text:initialize(id, text)
  Base.initialize(self, 1, id)
  self.text = text
end

function Text:draw()

end


GUI.Base = Base
GUI.Panel = Panel
GUI.Text = Text
GUI.Button = Button
GUI.Checkbox = Checkbox
GUI.List = List
GUI.Slider = Slider
GUI.Input = Input
GUI.Loader = Loader

return GUI

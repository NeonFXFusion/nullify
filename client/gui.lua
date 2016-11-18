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

function Panel:initialize(id, dim, margin)
  Base.initialize(self, 0, id)
  self.x = dim[0]
  self.y = dim[1]
  self.w = dim[2]
  self.h = dim[3]
  self.align = align
  self.margin = margin
  self.subelem = {} -- a table containing all of the subelements MUST BE INSTANCE OF GuiBase CLASS
end

function Panel:draw(x, y)
  local lx,ly,lw,lh
  -- TODO: OPTIMIZE THIS 
  if split(self.x, 'p')[1] == 'g' then
    -- lx = width * ((self.x + marginx) / 100)
    lx = love.graphics.getWidth() * (self.x / 100)  
  elseif split(self.x, 'p')[1] == 'l' then
    -- same but using parent width as base
  end
  if split(self.w, 'p')[1] == 'g' then
    -- lw = (self.w - marginx - marginh) / 100 * width
    -- lw = width * ((self.w - marginx - marginh) / 100)
    lw = love.graphics.getWidth() * (self.w / 100)  
  elseif split(self.w, 'p')[1] == 'l' then
    -- same but using parent width as base
  end
  if split(self.y, 'p')[1] == 'g' then
    ly = love.graphics.getHeight() * (self.y / 100)  
  elseif split(self.y, 'p')[1] == 'l' then
    -- same but using parent width as base
  end
  if split(self.h, 'p')[1] == 'g' then
    lh = love.graphics.getHeight() * (self.h / 100)  
  elseif split(self.h, 'p')[1] == 'l' then
    -- same but using parent width as base
  end
  -- margins are already in percantage so margin = height * margin/100 or something...
  -- x + marginx, y + marginy, w - marginx - marginw, h - marginy - marginh
  love.graphics.rectangle('line', lx, ly, lw, lh)
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

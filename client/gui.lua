local class = require 'middleclass'
local GUI = {}

local Base = class('GuiBase')

function Base:initialize(type, id)
  self.type = type
  self.id = id
  self.active = false
  self.x, self.y, self.w, self.h = -1
end

function Base:getX() return self.x end
function Base:getY() return self.y end
function Base:getWidth() return self.w end
function Base:getHeight() return self.h end

function Base:draw(x, y) end

function Base:pressed(btn) end -- event based so i wont call update for every gui element

function Base:hover(active) end -- called when hover started with active being true and ended with active false

function Base:update(dt) end -- updating only when element active


require 'util.string'

local Panel = class('GuiPanel', Base) -- any gui element must be in a Panel

function Panel:initialize(id, dim, margin)
  Base.initialize(self, 0, id)
  self.dim = dim;
  -- self.align = align
  self.margin = margin
  self.parent = nil -- parent element if any
  self.subelem = {} -- a table containing all of the subelements MUST BE INSTANCE OF GuiBase CLASS
  self:resize()
end

--TODO: Call this when window resize event recieved.
function Panel:resize()
  local x,y = 0,0 -- TODO: we need to account parents position
  local lx,ly,lw,lh
  local mw,mh
  -- margin
  if self.margin[1]:ends('g') then
    lx = (x+tonumber(self.margin[1]:split('g')[1])) / 100 * love.graphics.getWidth()
  elseif self.margin[1]:ends('l') then
    lx = (x+tonumber(self.margin[1]:split('l')[1])) / 100 * self.parent:getWidth()
  elseif self.margin[1]:ends('p') then
    lx = x+tonumber(self.margin[1]:split('p')[1])
  end

  if self.margin[2]:ends('g') then
    ly = (y+tonumber(self.margin[2]:split('g')[1])) / 100 * love.graphics.getHeight()
  elseif self.margin[2]:ends('l') then
    ly = (y+tonumber(self.margin[2]:split('l')[1])) / 100 * self.parent:getHeight()
  elseif self.margin[1]:ends('p') then
    ly = y+tonumber(self.margin[1]:split('p')[1])
  end

  if self.margin[3]:ends('g') then
    mw = tonumber(self.margin[3]:split('g')[1]) / 100 * love.graphics.getWidth()
  elseif self.margin[3]:ends('l') then
    mw = tonumber(self.margin[3]:split('l')[1]) / 100 * self.parent:getWidth()
  elseif self.margin[3]:ends('p') then
    mw = tonumber(self.margin[3]:split('p')[1])
  end

  if self.margin[4]:ends('g') then
    mh = tonumber(self.margin[4]:split('g')[1]) / 100 * love.graphics.getHeight()
  elseif self.margin[4]:ends('l') then
    mh = tonumber(self.margin[4]:split('l')[1]) / 100 * self.parent:getHeight()
  elseif self.margin[4]:ends('p') then
    mh = tonumber(self.margin[4]:split('p')[1])
  end
  -- dim
  -- TODO: First calculate width and height then calculate the rest of the margins then substract them from width and height to get lw and lh
  if self.dim[1]:ends('g') ~= nil then
    lw = tonumber(self.dim[1]:split('g')[1]) / 100 * love.graphics.getWidth()
  elseif self.dim[1]:ends('l') ~= nil then
    lw = tonumber(self.dim[1]:split('l')[1]) / 100 * self.parent:getWidth()
  elseif self.dim[1]:ends('p') ~= nil then
    lw = tonumber(self.dim[1]:split('p')[1])
  end
  lw = lw - lx - mw

  if self.dim[2]:ends('g') ~= nil then
    lh = tonumber(self.dim[2]:split('g')[1]) / 100 * love.graphics.getHeight()
  elseif self.dim[2]:ends('l') ~= nil then
    lh = tonumber(self.dim[2]:split('l')[1]) / 100 * self.parent:getHeight()
  elseif self.dim[2]:ends('p') ~= nil then
    lh = tonumber(self.dim[2]:split('p')[1])
  end
  -- THIS IS BAD MARGIN SHOULD NOT WORK LIKE THIS FOR EXAMPLE
  -- IF THE PANEL IS 50% WIDTH (or some other width) WITHA A MARGIN OF 10%
  -- THE MARGIN IS STILL DEDUCTED FROM THE WIDTH OF A PANEL EVEN THROUGH
  -- ITS BOUNDS ARE NOT BIGGER THAN ITS ROOT CONTAINER
  lh = lh - ly - mh

  self.x = lx
  self.y = ly
  self.w = lw
  self.h = lh
  for i, se in ipairs(self.subelem) do
    se:resize()
  end
end

function Panel:draw()
  self:resize()

  -- margins are already in percantage so margin = height * margin/100 or something...
  -- x + marginx, y + marginy, w - marginx - marginw, h - marginy - marginh
  local r,g,b,a = love.graphics.getColor()
  love.graphics.setColor(0, 255, 0)
  love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
  love.graphics.setColor(r,g,b,a)
end

function Panel:update(dt)

end

-- TODO: all other elements have static positioning based on panels. They get
-- positioned either equaly spread apart, like a list (aligned to either left,
-- right or center) !!!!NOT FINISHED THINK THIS THROUGH!!!!

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

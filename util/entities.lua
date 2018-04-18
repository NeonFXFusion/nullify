local class = require 'util.middleclass'
local Entity = {}

local Base = class('Entity')

function Base:initialize(type, x, y)
  self.type = type or error('Entity type cannot be nil.')
  self.x = x or 0
  self.y = y or 0
end

function Base:draw() end
function Base:update(dt) end

local Moving = class('EntityMoving', Base)

function Moving:initialize(type, x, y, velx, vely)
  Base.initialize(self, type, x, y)
  self.velx = velx or 0
  self.vely = vely or 0
end

function Moving:update(dt)
  self.x = self.x + = self.velx
  self.y = self.y + self.vely
end


local Item = class('EntityItem', Base)

function Item:initialize(itemData, x, y)
  Base.initialize(self, 2, x, y)
  self.itemData = itemData
end

function Item:draw() end
function Item:update(dt) end


local Char = class('EntityChar', Moving)

function Char:initialize(x, y, data)
  Base.initialize(self, 1, x, y)
  
end

function Char:draw() 
    
end

Entity.Base = Base;
Entity.Moving = Moving;
Entity.Item = Item;
Entity.Char = Char;

return Entity

local class = require 'util.middleclass'
local Entity = {}

local Base = class('Base')

function Base:initialize(type, x, y)
  self.type = type or error('Entity type cannot be nil.')
  self.x = x or 0
  self.y = y or 0
end

function Base:draw() end
function Base:update(dt) end

local Moving = class('Moving', Base)

function Moving:initialize(type, x, y, velx, vely)
  Base.initialize(self, type, x, y)
  self.velx = velx or 0
  self.vely = vely or 0
end

local Char = class('Char', Moving)

function Char:initialize(x, y, data)
  Base.initialize(self, 1, x, y)

end

function Char:draw() 
  
end

Entity.Base = Base;
Entity.Char = Char;

return Entity

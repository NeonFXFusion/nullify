local class = require 'middleclass'
local Entity = {}

local Base = class('Entity')

function Base:initialize(type, x, y)
  self.type = type or error('Entity type cannot be nil.')
  self.x = x or 0
  self.y = y or 0
end

function Base:draw() end
function Base:update(dt) end

local Char = class('Char', Base)

function Char:initialize(x, y, data)
  Base.initialize(self, 1, x, y)

end

Entity.Base = Base;
Entity.Char = Char;

return Entity

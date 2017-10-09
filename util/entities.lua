local class = require 'middleclass'
local Entity = {}

local Base = class('Entity')

function Base:initialize(x, y)
  self.x = x or 0
  self.y = y or 0
end

function Base:draw() end
function Base:update(dt) end

local Char = class('Char', Base)

function Char:initialize(x, y, data)
  Base.initialize(self, x, y)

end

Entity.Base = Base;
Entity.Char = Char;

return Entity

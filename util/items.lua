local class = require 'util.middleclass'
local Item = {}

local Base = class('ItemBase')

function Base:initialize(type, x, y)

end

Item.Base = Base

return Item
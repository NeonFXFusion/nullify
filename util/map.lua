local class = require 'middleclass'

require 'util.helper'

local Map = {}

local Complex = class('Complex')

function Complex:initialize(seed)

end

local Tree = class('Tree')

function Tree:initialize(leaf)
  self.leaf = leaf
  self.lchild = nil
  self.rchild = nil
end

function Tree:leaves()
  if self.lchild == nil and self.rchild == nil then
    return {self.leaf}
  else
    return nil
  end
end

local Tile = class('Tile')

function Tile:initialize(type, properties)
  self.type = type
  self.properties = properties
end

local District = class('District')

function District:initialize(seed, rank, size)
  self.seed = seed or 0
  self.rank = rank or 1
  self.size = size or 1
  self.tiles = nil
  self.points = nil
  self.canvas = nil
end

function District:generate()
  math.randomseed(self.seed)
  local w = 1000
  local h = 1000
  self.tiles = {}
  for y=1,h do
    self.tiles[y] = {}
    for x=1,w do
      if y == 1 or y == h then
        self.tiles[y][x] = {1}
      elseif y == 1 and x == 1 or x == x then
        self.tiles[y][x] = {1}
      else
        self.tiles[y][x] = {0}
      end
    end
  end
end

function District:tile(x, y)
  return self.tiles[y][x]
end

function District:draw()

end



Map.Complex = Complex
Map.District = District

return Map;

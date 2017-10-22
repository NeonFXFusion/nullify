local class = require 'middleclass'

local Map = {}

local Complex = class('Complex')

function Complex:initialize(seed)

end

local District = class('District')

function District:initialize(seed, rank, size)
  self.seed = seed or 0
  self.rank = rank or 1
  self.size = size or 1
  self.tiles = nil
  self.canvas = nil
end

function District:generate()
  -- {type, metadata}
  -- {0, {'decor':0}}
  math.randomseed(self.seed)
  local w = 100
  local h = 100
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

function District:draw()
  for y=1, #self.data do
    for x=1, #self.data[1] do
      if self.data[y][x] == 0 then
        love.graphics.setColor(240,240,240)
        love.graphics.rectangle('fill', x*40, y*40, 40,40)
        love.graphics.setColor(255,255,255)
      elseif self.data[y][x] == 1 then
        love.graphics.rectangle('fill', x*40, y*40, 40,40)
      elseif self.data[y][x] == 2 then
        love.graphics.setColor(240,240,240)
        love.graphics.rectangle('fill', x*40, y*40, 40,40)
        love.graphics.setColor(230,230,230)
        love.graphics.rectangle('fill', x*40, y*40, 40,20)
        love.graphics.setColor(255,255,255)

      end
    end
  end
end

Map.Complex = Complex
Map.District = District

return Map;

local class = require 'middleclass'

local Map = {}

local Complex = class('Complex')

function Complex:initialize(seed)

end

local Level = class('Level')

function Level:initialize(seed, rank, size)
  self.seed = seed or error('No seed was given to room.')
  self.rank = rank or 1
  self.size = size or 1
  self.data = nil
  self.canvas = nil
end

function Level:generate()

end

function Level:draw()
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

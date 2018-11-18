local class = require 'util.middleclass'
local moonshine = require 'client.moonshine'
local Event = require 'util.event'

require 'conf'
require 'util.helper'

local GUI = class('GUI')
--[[  structure = {
        {i="1" name="CONNECT"}, 
        {i="1.1" name="AUTO"}, 
        {i="1.2" name="CUSTOM"}, 
        {i="1.2.1" name="SUUB0"}, 
        {i="2" name="HOST"},
        {i="3" name="OPTIONS"}
        {i="3" name="EXIT"}
]]--  }

-- {{i="1" name="MENU0"}, {i="1.1" name="SUB0"}, {i="1.2" name="SUB1"}, {i="1.2.1" name="SUUB0"}, {i="2" name="MENU1"},{i="3" name="MENU2"}}
function GUI:initialize(structure)
  self.structure = structure
  self.cursor = '1'
  
  table.print(structure, 1)
  for k, v in pairs(self.structure) do
    if v['i']:count('%.') == 0 then 
      love.graphics.print(v['name'],200, 20*v['i']:split('.')[1])
    end
    --table.print(string.split(v['i'], '.'), 1)
  end
  self.updatable = {}

  for k, v in pairs(self.structure) do
    if v['listen'] ~= nil then 
      table.insert(self.updatable, v)
    end
  end
  table.print(self.updatable)
  self.effect = moonshine(moonshine.effects.glow).chain(moonshine.effects.scanlines).chain(moonshine.effects.chromasep)
  self.effect.glow.strength = 10
  self.effect.chromasep.angle = 0.4
  self.effect.chromasep.radius = 2
  self.effect.scanlines.thickness = 0.4
end

function GUI:loadfile(name)
  local ok, chunk, result
  ok, chunk = pcall( love.filesystem.load, name ) -- load the chunk safely
  if not ok then
    print('The following error happend: ' .. tostring(chunk))
  else
    ok, result = pcall(chunk) -- execute the chunk safely
   
    if not ok then -- will be false if there is an error
      print('The following error happened: ' .. tostring(result))
    else
      print('The result of loading is: ' .. tostring(result))
    end
  end
end

function GUI:draw()
  local prevf = love.graphics.getFont()
  local sizef = 24*love.graphics.scale()
  love.graphics.setFont(love.graphics.setNewFont('res/font/main.ttf', sizef))
  local i = 1-1
  --self.effect(function()
  for k, v in pairs(self.structure) do
    if v['i']:count('%.') == i then 
      love.graphics.print(v['name'],love.graphics.getWidth()*0.05, love.graphics.getHeight()*0.05+sizef*v['i']:split('.')[1+i])
    end
    --table.print(string.split(v['i'], '.'), 1)
  end
  --end)
  love.graphics.setFont(prevf)
end


function GUI:update(dt)
  self.effect.chromasep.radius = 2*love.graphics.scale()
  self.effect.scanlines.phase = math.random()*10
end

return GUI

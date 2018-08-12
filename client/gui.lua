local class = require 'util.middleclass'

local GUI = class('GUI')
--[[  structure = {
        {i="1" name="MENU0"}, 
        {i="1.1" name="SUB0"}, 
        {i="1.2" name="SUB1"}, 
        {i="1.2.1" name="SUUB0"}, 
        {i="2" name="MENU1"},
        {i="3" name="MENU2"}
]]--  }


function GUI:initialize(structure)
  self.structure = structure
  self.cursor = '1'
  print(dump(structure))
end

function GUI:draw()

end

function GUI:update(dt)

end

return GUI

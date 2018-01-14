local class = require 'util.middleclass'

local Logger = class('Logger')

function Logger:initialize(source)
  if source == nil then error('Could not spawn logger - source is nil.') end
  self.source = source;
end

function Logger:log(msg, level)
  if level == 1 then
    level = 'DEBUG'
  elseif level == 2 then
    level = 'WARN'
  elseif level == 3 then
    level = 'ERROR'
    print('['..os.date('%H:%M:%S')..']['..self.source..']['..level..']: '..msg)
    error(msg)
    return
  else
    level = 'INFO'
  end
  print('['..os.date('%H:%M:%S')..']['..self.source..']['..level..']: '..msg)
end

function Logger:info(msg)
  self:log(msg, 0)
end

function Logger:error(msg)
  self:log(msg, 3)
end

function Logger:warn(msg)
  self:log(msg, 2)
end

function Logger:debug(msg)
  self:log(msg, 1)
end

return Logger

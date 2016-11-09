local class = require 'middleclass'
local Timer = class('Timer')

function Timer:initialize(time, callback)
  self._time = time
  self._elapsed = 0
  self._paused = false
  self._finished = false
  self._callback = callback
end

function Timer:update(dt)
  if self._paused or self._finished then return end
  self._elapsed = self._elapsed + dt*1000
  if self._elapsed >= self._time * 1000 then
    if type(self._callback) == 'function' then self._callback() end
    self._finished = true
  end
end

function Timer:finished()
  return self._finished
end

function Timer:reset()
  self._elapsed = 0
  self._paused = false
  self._finished = false
end

function Timer:elapsed()
  return self._elapsed
end

function Timer:delay()
  return self._time
end

function Timer:toggle()
  self._paused = not self._paused
end

function Timer:destroy()
  self = nil
  collectgarbage()
end

return Timer

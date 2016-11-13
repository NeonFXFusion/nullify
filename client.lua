local class = require 'middleclass'
local Client = class('Client')

local sock = require 'sock'
local states = require 'client.states'
local Logger = require 'util.logger'

local debug = true

function Client:initialize(options)
  self.options = options
  self.gameState = states.Splash:new(self)
  self.log = Logger:new('CLIENT')
  self.log:info('Started default state.')
  -- client handles changes between state changes,
end

function Client:setState(state)
  if state.class.super == states.Base then
    self.gameState = state
  else
    self.log:error('Argument was not instance of StateBase')
  end
end

function Client:draw()
  if debug then
    love.graphics.print('FPS: '..love.timer.getFPS(),0, 0)
    love.graphics.print('STATE: '..self.gameState.class.name,0, 12)
  end
  if self.gameState.class.super == states.Base then
    self.gameState:draw()
  end
end

function Client:update(dt)
  if self.gameState.class.super == states.Base then
    self.gameState:update(dt)
  end
end

return Client

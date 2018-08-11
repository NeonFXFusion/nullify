local class = require 'util.middleclass'
local moonshine = require 'client.moonshine'

local State = {}

local options = {}

local Base = class('State')

function Base:initialize(id, client)
  if id == nil then error('State was initialized with nil id.') end
  if tostring(client.class) ~= 'class Client' then error('State '..id..' instance not client.') end
  self.id = id
  self.client = client
end

function Base:draw() end
function Base:update(dt) end

local Timer = require 'util.timer'

local Splash = class('StateSplash', Base)

function Splash:initialize(client)
  Base.initialize(self, 0, client)
  self.timer = Timer(5, function() client.log:info('Splash finished.') end)
  self.effect = moonshine(moonshine.effects.glow).chain(moonshine.effects.scanlines).chain(moonshine.effects.chromasep)
  self.effect.glow.strength = 10
  self.effect.chromasep.angle = 0.4
  self.effect.chromasep.radius = 1.5
  self.effect.scanlines.thickness = 0.4
end

function Splash:draw()
  -- opacity +=
  self.effect(function()
    local prevf = love.graphics.getFont()
    love.graphics.setFont(love.graphics.setNewFont('res/font/main.ttf', 60))
    love.graphics.printf("NULLIFY", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    love.graphics.setFont(prevf)
  end)
end

function Splash:update(dt)
  if true then
    self.effect.glow.strength = 10
    self.effect.chromasep.angle = 0.4
    self.effect.chromasep.radius = 1.5
    self.effect.scanlines.thickness = 0.4
    self.effect.scanlines.phase = self.timer:elapsed() / 15
  end
  if self.timer == nil then return end
  if self.timer:finished() then
    local state = State.Game:new(self.client)
    self.client:setState(state)
    -- self.timer.destroy()
    -- push Load state with a function that reads the config and then pushes
    -- main menu state with the read options.
  else
    if love.keyboard.isDown('escape') then
      self.timer:finish()
    end
    self.timer:update(dt)
  end
end

local Load = class('StateLoad', Base)

function Load:initialize(client, text, loader)
  Base.initialize(self, 1, client)
  self.text = text
  self.loader = loader -- function must return load percent from 0 - 1 or -1 and must accept dTime as argument
  self.percent = 0 -- if -1 then unknown load time otherwise from 0 to 1
end

function Load:draw()
  -- display logo or some shit
  -- display text
  -- display loading bar
end

function Load:update(dt)
  self.percent, self.load_state = self.loader(dt)
  if self.percent == 1 then
    -- love.event.push('clientstate', state)
  end
end

local Map = require 'util.map'

local Game = class('StateGame', Base)

function Game:initialize(client)
  Base.initialize(self, 3, client)
  local w = 100
  local h = 100
  self.data = {}
  for y=1,h do
    self.data[y] = {}
    for x=1,w do
      if y == 1 or y == h then
        self.data[y][x] = {1}
      elseif y == 1 and x == 1 or x == x then
        self.data[y][x] = {1}
      else
        self.data[y][x] = {0}
      end
    end
  end
  self.data = {
    {1,1,1,1,1,1,2},
    {1,0,0,0,0,2,1},
    {1,2,0,0,0,0,1},
    {1,1,2,0,0,0,1},
    {1,1,1,2,0,0,1},
    {1,0,2,0,0,0,0},
    {1,0,0,0,0,0,1},
    {1,2,0,0,2,0,1},
    {1,2,0,0,2,2,1},
    {1,0,0,0,0,2,1},
    {1,0,0,2,0,0,1},
    {1,2,0,0,0,2,1},
    {1,1,1,1,1,1,1}
  }
  self.effect = moonshine(moonshine.effects.glow)
  self.effect.glow.strength = 1
 -- self.effect.chromasep.angle = 0
  --self.effect.chromasep.radius = 1
end
-- Map:draw() Entity:draw() UI:draw()
offset = 100
offy = 100
offx = 100
size = 80
function Game:draw()
  --self.effect = moonshine(moonshine.effects.glow)
  love.graphics.print(#self.data,200, 0)
  love.graphics.print(#self.data[1],200, 10)
  for y=1, #self.data do
    for x=1, #self.data[1] do
      local bits = {}
      bits['l'] = self.data[y][x-1] or 0
      bits['r'] = self.data[y][x+1] or 0
      if self.data[y-1] then bits['t'] = self.data[y-1][x]  else bits['t'] = 0 end
      if self.data[y+1] then bits['b'] = self.data[y+1][x] else bits['b'] = 0 end

      love.graphics.setColor(0,255,0)
      --love.graphics.rectangle('line', offx+x*size, offy+y*size, 40, 40)
      love.graphics.print(self.data[y][x], offx+x*size, offy+y*size)
      if self.data[y][x] == 0 then

      elseif self.data[y][x] == 1 then
        love.graphics.setColor(255,255,255)
        love.graphics.setLineStyle('rough', 1)

        if bits['l'] == 0 then
          love.graphics.line(offx+x*size, offy+y*size-0.5, offx+x*size, offy+(y+1)*size+0.5)
        end
        if bits['r'] == 0 then
          love.graphics.line(offx+(x+1)*size, offy+y*size-0.5, offx+(x+1)*size, offy+y*size+size+0.5)
        end
        if bits['t'] == 0 then
          love.graphics.line(offx+x*size-0.5, offy+y*size, offx+(x+1)*size, offy+y*size)
        end
        if bits['b'] == 0 then
          love.graphics.line(offx+x*size-0.5, offy+(y+1)*size, offx+(x+1)*size+0.5, offy+(y+1)*size)
          love.graphics.line(offx+x*size-0.5, offy+(y+1)*size+size*0.35, offx+(x+1)*size+0.5, offy+(y+1)*size+size*0.35 )
          if bits['l'] == 0 then
            love.graphics.line(offx+x*size, offy+(y+1)*size-0.5, offx+x*size, offy+(y+1)*size+size*0.35+0.5)
          end
          if bits['r'] == 0 then
            love.graphics.line(offx+(x+1)*size, offy+(y+1)*size+size*0.35-0.5, offx+(x+1)*size, offy+y*size+0.5)
          end
        end


      elseif self.data[y][x] == 2 then
        love.graphics.setColor(255,255,255)
        love.graphics.setLineStyle('rough', 1)

        if not (bits['l'] == 0 and bits['b'] == 0 and bits['r'] == 0 and bits['t'] == 0) then
          
          if bits['l'] == 0 and bits['b'] == 0 and bits['r'] ~= 0 and bits['t'] ~= 0 then
            love.graphics.line(offx+x*size, offy+y*size, offx+(x+1)*size, offy+(y+1)*size)
            love.graphics.line(offx+x*size, offy+y*size+size*0.35, offx+(x+1)*size, offy+(y+1)*size+size*0.35)
            love.graphics.setColor(0, 0, 255)
            love.graphics.line(offx+x*size, offy+y*size, offx+x*size, offy+y*size+size*0.35)
          end

          if bits['l'] == 0 and bits['t'] == 0 and bits['r'] ~= 0 then
            love.graphics.line(offx+x*size, offy+(y+1)*size, offx+(x+1)*size, offy+(y)*size)
          end

          if bits['r'] == 0 and bits['b'] == 0 and bits['l'] ~= 0 then
            love.graphics.line(offx+x*size, offy+(y+1)*size, offx+(x+1)*size, offy+(y)*size)
            love.graphics.setColor(255, 0, 255)
            love.graphics.line(offx+x*size, offy+(y+1)*size+size*0.35, offx+(x+1)*size, offy+(y)*size+size*0.35)
            love.graphics.setColor(0, 255, 255)
            love.graphics.line(offx+(x+1)*size, offy+y*size, offx+(x+1)*size, offy+y*size+size*0.35)
            love.graphics.setColor(255, 255, 255)
          end

          if bits['r'] == 0 and bits['t'] == 0 and bits['b'] ~= 0 then
            love.graphics.line(offx+x*size, offy+y*size, offx+(x+1)*size, offy+(y+1)*size)
          end
        end
      end
    end
  end
end

function Game:update(dt)
  if love.keyboard.isDown('w') then
    offy = offy + dt * 200
  elseif love.keyboard.isDown('s') then
    offy = offy - dt * 200
  end
  if love.keyboard.isDown('a') then
    offx = offx + dt * 200
  elseif love.keyboard.isDown('d') then
    offx = offx - dt * 200
  end
  if love.keyboard.isDown('+') then 
    size = size + dt * 200
  elseif love.keyboard.isDown('-') then
    if size < 10 then return end
    size = size - dt * 200
  end
end
-- When the loader function completes the handshake with the server,
-- it then recieves information about the map, followed shortly after
-- by where the character is going to spawn and all of the entities in
-- the range of the spawn location then it starts the actual data streams.
-- Data streams between server and client are the following:
-- ALSO! If any movement data is off by more than 5%
-- (have to test in practice which % is best) kick that nigga
-- CLIENT > SERVER: movement data
-- CLIENT < SERVER: corrections if movement wrong, kick if BS data (wall clipping, out of bounds, etc)
-- C > S: action data (action click, action use item)
-- C < S: if bs timing (macro clicking) cancel event
-- C > S: pickup item
-- C < S: if too far or entity does not exist cancel event
-- C > S: change inventory (switch weapon, etc)
-- C < S: if bs timing (macro clicking) cancel event
-- S > C: damage event
-- S > C: death event
-- S > C: display leaderboard for end of match timer
-- S > C: server status: server loading, server stopping, match starting (with timer), waiting for players, match ending (with timer), match in progress
-- S > C: entity data (used for displaying and animating entities)
----------- + add/remove entity
----------- + hide/show entity
----------- + entity moved
----------- + entity damaged
----------- + entity death
----------- + entity Player specific data
---------------- + Player action
---------------- + Player equipment

-- Each type of entity should be in its own update thread depending on how much updates it gets.
-- For example static entities are stuff that does not more often like items, particle spawners etc
-- The player should be in its own thread. All projectiles are in another thread. All visible players are also in a seperate thread.
-- 5 Threads:
-- PLAYER CLIENT
-- PROJECTILES
-- PLAYER OTHER
-- PARTICLES (optional)
-- OTHER

-- Game state accepts the following arugments:
-- ip, port, server data (server status, player data (joined players and their status)), map data, entity list
-- when all of that is initialized then the game state waits until spawn location is recieved then data for all the entities
-- in that area. Then all it requires is a spawn command.

State.Base = Base
State.Splash = Splash
State.Load = Load
State.Menu = Menu
State.Game = Game

return State

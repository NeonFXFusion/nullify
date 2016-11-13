local class = require 'middleclass'
local State = {}

local Base = class('State')

function Base:initialize(id, client)
  if id == nil then error('State was initialized with nil id.') end
  if tostring(client.class) ~= 'class Client' then error('State '..id..' instance not client.') end
  self.id = id
  self.client = client
end

function Base:draw() end

function Base:update(dt) end

local Timer = require 'client.timer'

local Splash = class('StateSplash', Base)

function Splash:initialize(client)
  Base.initialize(self, 0, client)
  self.timer = Timer(5, function() client.log:info('Ayy lmao 5 seconds.') end)
end

function Splash:draw()
  -- opacity +=
end

function Splash:update(dt)
  if self.timer == nil then return end
  if self.timer:finished() then
    local state = State.Menu:new(self.client)
    self.client:setState(state)
    -- self.timer.destroy()
    -- push Load state with a function that reads the config and then pushes
    -- main menu state with the read options.
  else
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

local GUI = require 'client.gui'

local Menu = class('StateMenu', Base)

function Menu:initialize(client)
  Base.initialize(self, 2, client)
  -- init buttons
  -- PLAY
  -- opens a server browser to either join or host a game
  -- host button opens a menu to set the server settings
  -- SETTINGS
  -- opens a menu to disable particles, rebind keys etc
  -- LOADOUT
  -- edits the loadout of a character
  -- EXIT
  -- {0,0,100,100}
  self.root = GUI.Panel:new('root', 100, 100)
end

function Menu:draw()
  self.root:draw(0+10, 0+10)
  -- draw GUI
end

function Menu:update(dt)
  self.root:update(dt) -- minimal updates
  -- update GUI check for clicks etc
end

local Game = class('StateGame', Base)

function Game:initialize(client)
  Base.initialize(self, 3, client)

end

function Game:draw()

end

function Game:update(dt)

end
-- When the loader function completes the handshake with the server,
-- it then recieves information about the map, followed shortly after
-- by where the character is going to spawn and all of the entities in
-- the range of the spawn location then it starts the actual data streams.
-- Data streams between server and client are the following:
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

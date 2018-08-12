local class = require 'util.middleclass'

-- #1 make a config file for love2d to read +
-- #2 make a basic server
-- #2 basic client
-- #3 basic visuals for client and server
-- #4 main menu for client and introduce its game state manager
-- #4.5 menu is old school hack/console style
-- #5 expand on menus in the client
-- #6 begin with basic entity structures
-- #7 implement entity Player in client and server
-- #8 add basic packets for movement, damage and chat
-- #9 make tile structures, basic rendering
-- #10 create a map generator (look at dungeon generating examples, binary space partitioning?)
-- #11 implement server game state manager
-- #12 implement entity type Projectile, add on-hit events
-- #13 implement Item class start work on inventory
-- #14 add basic pickups, basic weapons
-- #15 expand on tiles
-- #16 make a modular item and projectile system
-- #17 !!! LIST UNFINISHED !!! ADD TO THE LIST !!!

-- CLIENT: gui - main menu, submenus (settings, login, etc), hud, inventory
-- CLIENT: game state manager - status not playing (not connected), playing, dead
-- BOTH: items - weapons, health and ammo pickup, stat boost
-- BOTH: tiles - wall, floor, ceiling, decor, interactable
-- BOTH: entities - Player, AI, interactable, projectiles
-- CLIENT: particles (separate to entities since we are going to utilise the GPU)
-- SERVER: map generator
-- SERVER: game state manager - status pre-game, in-game, post-game
-- CLIENT: text formatting codes - colors, bold, italic, underlined, crossed, crypted, rainbow
-- CLIENT: rendering of stuff
-- SERVER: some sort of item drop system probably using a HIVE.

local Client = require 'client'
local Server = require 'server'
local Logger = require 'util.logger'
local Event = require 'util.event'

local log = Logger:new('BASE')

function love.load()
  log:info('Loading...')
  -- TODO: if any console arguments intended for client pass them through
  love.client = Client:new()
  -- injected handlers for starting and stopping the internal server
  love.handlers.serverstart = function(ip, port, options)

  end
  love.handlers.serverstop = function()

  end
  log:info('Done loading.')
end

function love.draw()
  love.client:draw()
end

function love.update(dt)
  love.client:update(dt)
end

function love.focus(focus)
  Event.trigger('WINDOW_FOCUS', focus)
end

function love.keypressed(key, scancode, isrepeat)
  Event.trigger('KEY_PRESS', key, scancode, isrepeat)
end

function love.quit()
  Event.trigger('WINDOW_QUIT')
  log:info('Quitting :(')
  return false
end

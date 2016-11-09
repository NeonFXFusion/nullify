local class = require 'middleclass'

-- #1 !!!DONE!!! make a config file for love2d to read !!!DONE!!!
-- #2 make a basic server
-- #2 basic client
-- #3 basic visuals for client and server
-- #4 main menu for client and introduce its game state manager
-- #5 expand on menus in the client
-- #6 begin with basic entity structures
-- #7 implement entity Player in client and server
-- #8 add basic packets for movement, damage and chat
-- #9 make tile structures, basic rendering
-- #10 create a map generator (look at dungeon generating examples, binary space partitioning?)
-- #11 expand on server/client gui, implement server game state manager
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

function love.load()
  love.handlers.log = function(msg, src, level)
    if src == nil then src = 'BASE' end
    if level == 1 then
      level = 'DEBUG'
    elseif level == 2 then
      level = 'WARN'
    elseif level == 3 then
      level = 'ERROR'
      print('['..os.date('%H:%M:%S')..']['..src..']['..level..']: '..msg)
      error(msg)
      return
    else
      level = 'INFO'
    end
    print('['..os.date('%H:%M:%S')..']['..src..']['..level..']: '..msg)
  end
  love.event.push('log', 'Loading...')
  -- TODO: if any console arguments intended for client pass them through
  client = Client:new()
  love.handlers.clientstate = function(state)
    client:setState(state)
  end
  love.handlers.serverstart = function(ip, port, serverName, serverMOTD, gamemode)

  end
  love.handlers.serverstop = function()

  end
  love.event.push('log', 'Done loading.')
end

function love.draw()
  client:draw()
end

function love.update(dt)
  client:update(dt)
end

function love.focus()

end

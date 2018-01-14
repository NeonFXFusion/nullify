local class = require 'util.middleclass'
local Server = class('Server')

local sock = require 'util.sock'
local Logger = require 'util.logger'

function Server:initialize(ip, port, options)
  self.ip = ip or '*'
  self.port = port or 36069
  self.log = Logger:new('SERVER')
  if options then
    self.options.serverName = options.serverName or 'Server'
    self.options.serverMOTD = options.serverMOTD or 'How are you today?'
    self.options.maxPlayers = options.maxPlayers or 8
    self.options.maxSpectators = options.maxSpectators or 2
    self.options.gameMode = options.maxSpectators or 0 -- 0: FFA, 1: TDM
    self.options.enforceAuth = options.enforceAuth or false -- weather or not to check for valid session keys from users if disabled user can connect with whatever username they would like
  end
end

function Server:start()
  self.log:info('Starting server...')
  -- max players is actual players + spectators and one admin slot
  self.server = sock.newServer(self.ip, self.port, self.options.maxPlayers + self.options.maxSpectators+1)
  self.server:on('connect', function(data, client)
    self.log:info(client.." :: "..data)
  end)
end

function Server:internal()
  return self.server
end

function Server:update(dt)
  self.server:update()
end

return Server

local class = require 'middleclass'
local Server = class('Server')

local sock = require 'sock'
local Logger = require 'util.logger'

function Server:initialize(ip, port, options)
  self.ip = ip
  self.port = port
  self.log = Logger:new('SERVER')
  self.options.serverName = 'Server'
  self.options.serverMOTD = 'How are you today?'
  self.options.maxPlayers = 8
  self.options.maxSpectators = 2
  self.options.gameMode = 0 -- 0: FFA, 1: TDM
  self.options.enforceAuth = false -- weather or not to check for valid session keys from users if disabled user can connect with whatever username they would like

end

function Server:start()
  self.server = sock.newServer(self.ip, self.port, self.options.maxPlayers + self.options.maxSpectators+1)
  self.server:on('connect', function(data, client)

  end)
end

function Server:internal()
  return self.server
end

function Server:update(dt)
  self.server:update()
end

return Server

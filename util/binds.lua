--[[ 
format is 
['<action>'] = {
  ['<type>'] = <button>'
}


--]]
local binds = {}

binds = {
  ['up'] = {
    ['key'] = 'w'
  },
  ['down'] = {
    ['key'] = 's'
  },
  ['left'] = {
    ['key'] = 'a'
  },
  ['right'] = {
    ['key'] = 'd'
  },
  ['interact'] = {
    ['key'] = 'e'
  },
  ['menu_toggle'] = {
    ['key'] = 'escape'
  }
}

binds.add = function(action, key)

end

binds.remove = function(action, key)

end

binds.active = function(action)
  for k, v in pairs(binds[action]) do
    if k == 'key' then
      return love.keyboard.isDown(binds[action][k])
    elseif k == 'keycode' then
      return love.keyboard.isScancodeDown(binds[action][k])
    end
  end
end

return binds
Event = {}

local events = {}

function Event.trigger(name, ...)
  local eventlist = events[name] or {}

  for obj, callback in pairs(eventlist) do
    if type(obj) == 'function' then
      obj(name, ...)
    elseif obj[name] then
      obj[name](obj, name, ...)
    elseif obj.on then
      obj:on(name, ...)
    end
  end
end

function Event.addCallback(obj, ...)
  if not obj then
    return error('Event.addCallback: callback can\'t be nil', 2)
  end
    
  local names = type(...) == 'table' and ... or {...}
  
  if #names == 0 then
    return error('Event.addCallback: name can\'t be nil', 2)
  end
  
  for i, name in ipairs(names) do
    if type(name) == 'string' then
      local eventlist = events[name]
      
      if not eventlist then
        eventlist = {}
        setmetatable(eventlist, {__mode='k'}) -- weak keys so garbage collector can clean up properly
      end
      
      if type(obj) ~= 'function' and type(obj) ~= 'table' then
        return error('Event.addCallback: callback object isn\'t a table or function', 2)
      end
      
      eventlist[obj] = true
      events[name] = eventlist
    end
  end
  
  return obj
end

function Event.removeCallback(obj, ...)
  if not obj then
    return error('Event.removeCallback: callback can\'t be nil', 2)
  end
  
  local names = type(...) == 'table' and ... or {...}
  
  if #names == 0 then
    return error('Event.removeCallback: name can\'t be nil', 2)
  end
  
  for i, name in ipairs(names) do
    local eventlist = events[name]
    if eventlist and eventlist[obj] then
      eventlist[obj] = nil
    end
  end
end

function Event.lookup(obj)
  if type(obj) ~= 'table' and type(obj) ~= 'function' then
    return error('Event.lookup: callback object isn\'t table or function', 2)
  end
  
  local registered = {}
  
  for eventname, eventlist in pairs(events) do
    for _obj, callback in pairs(eventlist) do
      if obj == _obj then
        table.insert(registered, eventname)
        break
      end
    end
  end
  
  return registered 
end

return Event
function string:split(sSeparator, nMax, bRegexp)
   assert(sSeparator ~= '')
   assert(nMax == nil or nMax >= 1)

   local aRecord = {}

   if self:len() > 0 then
      local bPlain = not bRegexp
      nMax = nMax or -1

      local nField, nStart = 1, 1
      local nFirst,nLast = self:find(sSeparator, nStart, bPlain)
      while nFirst and nMax ~= 0 do
         aRecord[nField] = self:sub(nStart, nFirst-1)
         nField = nField+1
         nStart = nLast+1
         nFirst,nLast = self:find(sSeparator, nStart, bPlain)
         nMax = nMax-1
      end
      aRecord[nField] = self:sub(nStart)
   end

   return aRecord
end

function string:starts(start)
   return string.sub(self,1,string.len(start))==start
end

function string:ends(last)
   return last=='' or string.sub(self,-string.len(last))==last
end

function string:count(pattern)
    return select(2, string.gsub(self, pattern, ""))
end

function table.copy( t, ... )
	local copyShallow = function( src, dst, dstStart )
		local result = dst or {}
		local resultStart = 0
		if dst and dstStart then
			resultStart = dstStart
		end
		local resultLen = 0
		if "table" == type( src ) then
			resultLen = #src
			for i=1,resultLen do
				local value = src[i]
				if nil ~= value then
					result[i + resultStart] = value
				else
					resultLen = i - 1
					break;
				end
			end
		end
		return result,resultLen
	end
	local result, resultStart = copyShallow( t )
	local srcs = { ... }
	for i=1,#srcs do
		local _,len = copyShallow( srcs[i], result, resultStart )
		resultStart = resultStart + len
	end

	return result
end

function table.print(tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      table.print(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))      
    elseif type(v) == 'function' then
      print(formatting .. tostring(v))      
    else
      print(formatting .. v)
    end
  end
end

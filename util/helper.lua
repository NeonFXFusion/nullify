function string:split(delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( self, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end

function string:starts(start)
   return string.sub(self,1,string.len(start))==start
end

function string:ends(last)
   return last=='' or string.sub(self,-string.len(last))==last
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

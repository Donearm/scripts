#!/usr/bin/env lua

-- @copyright 2011-2013, Gianluca Fiore © <forod.g@gmail.com>

--- Converts seconds into minutes as MM:SS
--@param secs the integer with the seconds
function secs2mins(secs)
	local secs = tonumber(secs)
	if secs > 59 then
		local minutes = math.floor(secs/60)
		local seconds = secs - (minutes * 60)
		
		if seconds < 10 then
			seconds = "0" .. seconds
		end

		local totaltime = minutes .. ":" .. seconds
		return totaltime
	else
		if secs < 10 then
			seconds = "0" .. secs
		else
			seconds = secs
		end

		local totaltime = "0:" .. seconds

		return totaltime
	end
end

--- Converts seconds into a full clock representation, like HH:MM:SS
--@param secs the integer with the seconds
function secs2clock(secs)
	local secs = tonumber(secs)
	if secs == 0 then
		return "00:00:00"
	else
		local hours = string.format("%02.f", math.floor(secs/3600))
		local minutes = string.format("%02.f", math.floor(secs/60 - (hours * 60)))
		local seconds = string.format("%02.f", math.floor(secs - hours * 3600 - minutes * 60))
		local totaltime = hours .. ":" .. minutes .. ":" .. seconds
		return totaltime
	end
end

s = secs2clock(arg[1])
--s = secs2mins(arg[1])
print(s)

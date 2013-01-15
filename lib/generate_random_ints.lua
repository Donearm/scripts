#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2011-2013 Gianluca Fiore <forod.g@gmail.com>
--

---Pick n unique random numbers between a min and a max
--@param n the number of integers to generate
--@param min the lowest number that can be randomly generated
--@param max the highest number that can be randomly generated
function unique_rand(n, min, max)
	local res, buf = {}, {}
	local range = max - min + 1
	assert(n <= range)
	for i=1,n do
		local r = math.random(range) - 1
		range = range - 1
		res[i] = (buf[r] or r) + min
		buf[r] = buf[range] or range
	end
	return res
end

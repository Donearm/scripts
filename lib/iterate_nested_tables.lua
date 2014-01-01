#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2012-2014, Gianluca Fiore <forod.g@gmail.com>
--

function print_tables(t)
	if type(t) == "table" then
		for k,v in pairs(t) do
			print(k)
			print_tables(v)
		end
	else
		-- not a table? Then just print it
		print(t)
	end
end

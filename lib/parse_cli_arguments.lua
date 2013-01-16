#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2013, Gianluca Fiore <forod.g@gmail.com>
--

function cli_parse(...)
	local args = ...
	local files = {} -- if needed, a table to contain the files (= everything doesn't begin with 1 or 2 "-")
	for i = #args, 1, -1 do
		local a = arg[i]
		-- insert code to match flags
	end
end

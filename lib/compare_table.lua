#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2011 Gianluca Fiore <forod.g@gmail.com>
--

---"Setify" a table, using the items as string indices and their values 
--all true
--@param t the table to transform in a set
function table.set(t)
	local u = {}
	for _,v in ipairs(t) do
		u[v] = true 
	end
	return u
end

---Compare a table contents with a set (table with string index and true 
--values) and return a table containing only the elements not presents 
--in the set
--@param s the set
--@param t a table
function table.setcompare(s, t)
	local u = {}
	for _,v in ipairs(t) do
		if not s[v] then
			table.insert(u, v)
		end
	end
	return u
end

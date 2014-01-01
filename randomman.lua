#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2014, Gianluca Fiore <forod.g@gmail.com>
--

local PATH = '/usr/bin'

---Extract a random command in a path and open its manpage, 
---recursively rerunning itself if there's none.
--@param path the path to search in
function find_a_page(path)
	local cmd = io.popen("ls " .. path .. " | shuf | head -1") -- only 1 element
	local cmd_str = cmd:read("*all")
	-- check with "man -w" if a manpage exists
	local manpage_exist = assert(io.popen("man -w " .. cmd_str):read("*all"))
	-- if it starts with a '/', there's a manpage path so we can show it
	if string.match(manpage_exist, '^/') then
		os.execute("man " .. cmd_str)
		os.exit(0)
	else
		-- no manpage found, retry with another command
		find_a_page(path)
	end
end


-- redundant but hey, I like main() :)
function main()
	find_a_page(PATH)
end

main()

#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2012-2013, Gianluca Fiore <forod.g@gmail.com>
--
--
-- Open a url with feh, if it leads to an image, or firefox, in all 
-- other cases. Trivial but very useful with cli newsreaders (like 
-- newsbeuter) to quickly preview images and to not have to switch to 
-- the browser's desktop for every url

-- Regexp for images
local rImages = ".*%.[jJGgpP][pPiInN][eE]?[gGfF]"

-- exit if not arguments given
if not arg[1] then
	os.exit(1)
end

if string.match(arg[1], rImages) then
	local f = os.execute('feh ' .. arg[1])
	os.exit(0)
else
	local b = os.execute('firefox ' .. arg[1])
	os.exit(0)
end

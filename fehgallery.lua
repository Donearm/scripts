#!/usr/bin/env lua

local lfs = require("lfs")
local string = require("string")
local table = require("table")
local os = require("os")


-- some regexp
rImages = ".*%.[tjgpTJGP][pinPIN][eE]?[gfGF]" -- image files
rFehList = "feh.*_filelist" -- feh filelists

-- concatenating all arguments from 1 onward to allow files with spaces 
-- (still needs escaping when directly invoked by the shell)
local firstfile = table.concat(select(1, arg))
local collate = os.getenv("LC_COLLATE") -- LC_COLLATE locale, to sort tables
os.setlocale(collate)

-- Function equivalent to basename in POSIX systems
function basename(str)
	local name = string.gsub(str, "(.*/)(.*)", "%2")
	return name
end
-- Function equivalent to dirname in POSIX systems
function dirname(str)
	local name = string.gsub(str, "(.*/)(.*)", "%1")
	return name
end

function splittable(t, pattern)
	-- explanation: taking a table (t) and a pattern to match, iterate 
	-- over t and when matching a pattern, and being sure that tableA is 
	-- empty, add it as first value; then add all subsequent values 
	-- after it, while keeping precedent ones in tableB.
	-- After all this, append values in tableB into tableA so they 
	-- will be at the end, with the value matching as first of the 
	-- new table
	-- WARNING: this comparation only works for filenames not containing 
	-- unicode characters. If they do, sorting is screwed, see 
	-- http://lua-users.org/wiki/LuaUnicode
	local tableA = {}
	local tableB = {}
	for _,n in ipairs(t) do
--		if string.match(n, basename(firstfile)) and next(tableA) == nil then
		if n == basename(firstfile) and next(tableA) == nil then
			table.insert(tableA, 1, n)
		elseif next(tableA) ~= nil then
			table.insert(tableA, n)
		else
			table.insert(tableB, n)
		end
	end
	for _,n in ipairs(tableB) do
		table.insert(tableA, n)
	end

	return tableA
end

-- get dirname of firstfile, chdir into it and reassign directory variable
local directory = dirname(firstfile)
lfs.chdir(directory)
local directory = lfs.currentdir()


local filelist = {}
for f in lfs.dir(directory) do
	-- iterate the directory, if f doesn't start with a word or an 
	-- underscore sign, skip it
	if string.match(f, "^[_%-%w]") then
		-- check attributes of every file and check if they are actually that
		-- and not directories
		local attr = lfs.attributes(directory .. '/' .. f)
		if attr.mode ~= "directory" then
			if string.match(f, rImages) then
				-- only proper image files please
				table.insert(filelist, f)
			end
		end
	end
end

table.sort(filelist)

local finaltable = splittable(filelist, basename(firstfile))

for i,n in ipairs(finaltable) do
	-- add the path, relative to directory of where the script was 
	-- started, to each filename in finaltable
	local abspath_n = directory .. '/' .. n
	-- escape any troublesome character for the shell
	local escaped_n = string.gsub(abspath_n, "([%s\'\"\\%(%)%[%]%{%}&$%~%,%;%%])", "\\%1")
	finaltable[i] = escaped_n 
end

-- join all images in a long string and launch feh
local imagestring = table.concat(finaltable, ' ')
os.execute('feh ' .. imagestring .. ' &')

-- remove fehlists
for f in lfs.dir(directory) do
	if string.match(f, rFehList) then
		os.remove(f)
	end
end

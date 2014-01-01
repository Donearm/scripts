#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2011-2014, Gianluca Fiore <forod.g@gmail.com>
--

local lfs = require("lfs")

local DIR = arg[1]
local PERCENTAGE = arg[2]
-- declare the table to contain the numeric index of files to keep
local NUMERIC_KEEPTABLE = {}
-- and the table to actually contain the filenames to keep
local KEEPTABLE = {}

-- commented because #FILETABLE will suffice when using lfs
--local FILECOUNT = string.gsub(io.popen("ls -A " .. DIR .. " | wc -l"):read("*a"), "\n", "")
-- this is commented because it's not needed with lfs
--local FILELIST = { io.popen("ls -1 " .. DIR):read("*a") }

---Generate a table with unique random integers
--@param n the number of integers to generate
--@param min the lowest number that can be randomly generated
--@param max the highest number that can be randomly generated
function unique_rand(n, min, max)
	local res, buf = {}, {}
	local range = max - min + 1
	assert(n <= range)
	-- set random seed to current date in ms
	local milliseconds = io.popen("date +%N"):read("*a")
	math.randomseed(milliseconds)
	for i=1,n do
		local r = math.random(range) - 1
		range = range - 1
		res[i] = (buf[r] or r) + min
		buf[r] = buf[range] or range
	end
	return res
end

---"Setify" a table, using the items as string indices and their values 
--set all true
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

-- declare a table and insert all filenames in DIR
local FILETABLE = {}
for f in lfs.dir(DIR) do
	if f ~= "." and f ~= ".." then
		table.insert(FILETABLE, f)
	end
end

-- simple version without requiring lfs. Stops working when filenames 
-- contain spaces
--for w in FILELIST[1]:gmatch("%S+") do 
--	table.insert(FILETABLE, w)
--end

print("How many files do we have? ", #FILETABLE)

-- calculate the number of files to keep based on the wanted percentage
local to_keep = math.ceil(#FILETABLE / 100 * PERCENTAGE)

print("The number of files to keep is ", to_keep)

NUMERIC_KEEPTABLE = unique_rand(to_keep, 1, #FILETABLE)

for _,n in ipairs(NUMERIC_KEEPTABLE) do
	table.insert(KEEPTABLE, FILETABLE[n])
end

-- change into DIR
lfs.chdir(DIR)

-- Make a set out of the table of files to keep
local set_keeptable = table.set(KEEPTABLE)

-- and generate a new table comparing the complete and the keeptable 
-- tables
local to_delete_table = table.setcompare(set_keeptable, FILETABLE)

-- delete every file in the to_delete_table
for _,e in ipairs(to_delete_table) do
	print("Deleting " .. e)
	local status = os.execute("rm -rf " .. e)
end

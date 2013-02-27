#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2012-2013, Gianluca Fiore <forod.g@gmail.com>
--

package.path = "/mnt/d/Script/lib/?.lua;" .. package.path
local markdown = require("markdown") -- that's the markdown.lua implementation from http://www.frykholm.se/files/markdown.lua
local lfs = require("lfs")

-- Regexp to match markdown files
local rMdown = ".*%.[mM][aA]?[rR]?[kK]?[dD][oO]?[wW]?[nN]?"

-- html closing string
local html_footer = [[</body></html>]]

local usage = [[USAGE: Markdown.lua (file|directory) [title]

where file is a file containing markdown formatted text or where directory
is a valid path having under it one or more markdown formatted files
title is an optional string to be used in the <title> html tag]]

---Function equivalent to POSIX basename
--@param str a string
function basename(str)
	local name = string.gsub(str, "(.*/)(.*)", "%2")
	return name
end

---Returns only the filename stripping the extension
--@param str a filename complete with extension
function filename(str)
	local name = string.gsub(str, "(.*)%.(.*)", "%1")
	return name
end

---Returns the html header by check if the parameter given is a string; 
--if not, return basename of file or the string in the <title> tag
--@param v the value to be returned, if a string
function generate_html_header(v)
	-- two strings, up until and thereafter the title tag
	local html1 = [[ <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<title>]]
	local html2 = [[</title> 
	<link rel="stylesheet" type="text/css" href="file:///mnt/d/Script/lib/markdown.css" />
	<link rel="stylesheet" type="text/css" media="print" href="file:///mnt/d/Script/lib/markdown-print.css" />
</head>
<body>
]]
	if type(v) == 'string' then
		return html1 .. v .. html2
	else
		return html1 .. basename(arg[1]) .. html2
	end
end

---Convert a markdown file to one with the same name but in html
--@param file the file to convert
function mkdtohtml(file)
	local f = assert(io.open(file, "r"), "couldn't open file")
	local n = filename(file)

	local html_file = io.open(n .. '.html', "w")
	html_file:write(generate_html_header(arg[2]))
	html_file:write(markdown(f:read("*a")))
	html_file:write(html_footer)
	html_file:close()
end

---Check if a path exists and if it does, return a string telling 
--whether it is a file or a directory
--@param path the path to check
function fileordir(path)
	attrs = lfs.attributes(path)
	if not attrs then
		print(path, " is not a valid directory or file")
		print(usage)
		os.exit(1)
	else
		if attrs.mode == "directory" then
			return 'directory'
		else
			return 'file'
		end
	end
end

---Search inside a directory for all markdown files and adds them all to 
--a table
--@param dir the base directory into which to search
--@param tbl the table that will contain all file paths
function browseformkd(dir, tbl)
	for f in lfs.dir(dir) do
		if f ~= "." and f ~= ".." then
			local file = dir .. "/" .. f
			local attr = lfs.attributes(file)
			if attr.mode == "directory" then
				browseformkd(file, tbl)
			else
				if string.match(file, rMdown) then
					-- it's a markdown file then, add to the table
					table.insert(tbl, file)
				end
			end
		end
	end
end

if not arg[1] then
	print(usage)
	os.exit(1)
else
	path = fileordir(arg[1])
	if path == 'file' then
		mkdtohtml(arg[1])
	else
		-- The table containing all mkdown files
		local mkdtable = {}

		browseformkd(arg[1], mkdtable)
		for i,n in ipairs(mkdtable) do
			mkdtohtml(n)
		end
	end
end

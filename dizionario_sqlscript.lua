#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2011-2015, Gianluca Fiore <forod.g@gmail.com>
--

-- Multi-language script to look up a dictionary in the form of a Sqlite 
-- file
package.path = "/mnt/d/Script/lib/?.lua;" .. "/mnt/documents/d/Script/lib/?.lua;" .. package.path
local os = require("os")
local ansicolors = require("ansicolors")

local DICTIONARY
local LANGUAGE
local WORD

--Check if db file exists from a path
--@db_file path to db file
function db_exists(dbfile)
	f = io.open(dbfile)
	if f ~= nil then
		io.close(f)
		return dbfile
	else
		return nil
	end
end
local DICTIONARY = db_exists('/mnt/d/Lingue/dictionary.db') or db_exists('/mnt/documents/d/Lingue/dictionary.db')

---Help message
function help()
	print([[Use: -e for English, -d for Deutsch, -c for Czech, -o for Polish, -s for Spanish or -p for Portuguese]])
	print([[	append -a to insert a new word or -au to insert a new untraceable word 
	or -r to replace an existing word]])
	print("\n\tExample: -e -a to add a word to the English dictionary\n")
	os.exit()
end

---Double any single quote in a string
--@param s The string to escape its quotes
function escape_quotes(s)
	if s:match("%'") then
		return string.gsub(s, "%'", "%1%1")
	else
		return s
	end
end


---Add a word and its translation in a sqlite table
--@param w The word to add
--@param tr The translation(s), comma separated
--@param t The table to add the word
function add_word(w, tr, t)
	local w = escape_quotes(w)
	if not tr then
		local r = assert(io.popen("sqlite3 " .. DICTIONARY .. [[ "insert into ]] .. t .. [[ values(']] .. w .. [[');"]]))
	else
		local tr = escape_quotes(tr)
		local r = assert(io.popen("sqlite3 " .. DICTIONARY .. [[ "insert into ]] .. t .. [[ values(']] .. w .. [[', ']] .. tr .. [[');"]]))
	end
end

---Look up a word in a sqlite dictionary
--@param w The word to look up
--@param t The table where to look for the word
--@param c The column to print
function look_up(w, t, c)
	local w = escape_quotes(w)
	local t = assert(io.popen("sqlite3 " .. DICTIONARY .. [[ "select ]] .. c .. [[ from ]] .. t .. [[ where Word = ']] .. w .. [['"]], 'r'))
	local r = assert(t:read("*a"))
	t:close()
	return r
end

---Replace the translation of a word
--@param w The word
--@param t The table where the word is
--@param tr The new translation to replace the old one
function replace_translation(w, t, tr)
	local w = escape_quotes(w)
	local tr = escape_quotes(tr)
	local r = assert(io.popen("sqlite3 " .. DICTIONARY .. [[ "update or replace ]] .. t .. [[ set Translation = ']] .. tr .. [[' where Word = ']] .. w .. [['";]]))
	if not r then
		print("Couldn't update the translation, check if the word is actually in the table")
	end
end

---Delete a translation from a dictionary
--@param w The word to delete
--@param t The table into which to look for the word
function delete_translation(w, t)
	local w = escape_quotes(w)
	local r = assert(io.popen("sqlite3 " .. DICTIONARY .. [[ "delete from ]] .. t .. [[ where Word = ']] .. w .. [['"]]))
	if not r then
		print("Word was not found in the dictionary...")
	end
end

function main()
	if not arg[1] then
		-- no arguments
		help()
	else
		print("Small Dictionary " .. ansicolors.blue .. "English" .. ansicolors.reset .. "/" 
		.. ansicolors.yellow .. "Deutsch" .. ansicolors.reset .. "/" .. ansicolors.cyan .. 
		"Czech" .. ansicolors.reset .. "/" .. ansicolors.magenta .. "Polish" .. 
		ansicolors.reset .. "/" .. ansicolors.red .. "Spanish" .. ansicolors.reset 
		.. "/" .. ansicolors.green .. "Portuguese" .. ansicolors.reset .. "-Italian")

		-- check if the first argument is correct
		if arg[1] == "-e" then
			LANGUAGE = "English"
			print(ansicolors.blue .. '(English-Italian)' .. ansicolors.reset)
			print("\n")
		elseif arg[1] == "-d" then
			LANGUAGE = "Deutsch"
			print(ansicolors.yellow .. '(Deutsch-Italian)' .. ansicolors.reset)
			print("\n")
		elseif arg[1] == "-c" then
			LANGUAGE = "Czech"
			print(ansicolors.cyan .. '(Czech-Italian)' .. ansicolors.reset)
			print("\n")
		elseif arg[1] == "-o" then
			LANGUAGE = "Polish"
			print(ansicolors.magenta .. '(Polish-Italian)' .. ansicolors.reset)
			print("\n")
		elseif arg[1] == "-s" then
			LANGUAGE = "Spanish"
			print(ansicolors.red .. '(Spanish-Italian)' .. ansicolors.reset)
			print("\n")
		elseif arg[1] == "-p" then
			LANGUAGE = "Portuguese"
			print(ansicolors.green .. '(Portuguese-Italian)' .. ansicolors.reset)
			print("\n")
		else
			help()
		end

		-- check if there is a second argument. If affirmative, it'll be 
		-- the word to look up in the dictionary
		if not arg[2] then
			repeat
				io.write("Look up a word: ")
				io.flush()
				WORD = io.read()
			until WORD
		else
			if arg[2] == "-a" then
				-- add a word and its translation
				local w, tr
				repeat
					io.write("Add Word: ")
					io.flush()
					w = io.read()
				until w
				repeat
					io.write("Its translation(s): ")
					io.flush()
					tr = io.read()
				until tr
				add_word(w, tr, LANGUAGE)
				os.exit()
			elseif arg[2] == "-au" then
				-- add a word among the untraceables
				local w
				repeat
					io.write("Add an untraceable: ")
					io.flush()
					w = io.read()
				until w
				add_word(w, nil, 'U_' .. LANGUAGE)
				os.exit()
			elseif arg[2] == "-r" then
				-- replace an existing translation then
				local w, tr
				print("Replacing an existing translation mode")
				repeat
					io.write("Which word? ")
					io.flush()
					w = io.read()
				until w
				repeat
					io.write("Insert the new translation(s): ")
					io.flush()
					tr = io.read()
				until tr
				replace_translation(w, LANGUAGE, tr)
				os.exit()
			elseif arg[2] == "-d" then
				-- delete a translation
				local w
				print("Removing a translation mode")
				repeat
					io.write("Which word to delete? ")
					io.flush()
					w = io.read()
				until w
				delete_translation(w, LANGUAGE)
				os.exit()
			else
				-- there could be more words. Concatenate them all using a 
				-- single space as the separator character
				WORD = table.concat(arg, ' ', 2, #arg)
			end
		end

		-- check if the word is present in the dictionary
		local result = look_up(WORD, LANGUAGE, 'Translation')
		if result == '' then
			-- word not present, search among the untraceables
			local untraceable_word = look_up(WORD, 'U_' .. LANGUAGE, 'Word')
			if untraceable_word ~= '' then
				print(WORD .. ' is among the untraceables')
			else
				print(WORD .. ' not found')
			end
		else
			print(result)
			os.exit()
		end
	end
end

main()

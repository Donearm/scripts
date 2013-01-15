#!/usr/bin/env lua

--- Return a table with files and directories present in a path
--@path the path
--@prepend_path_to_filename if True, prepend path to filenames
local function get_files(path, prepend_path_to_filenames)
   if path:sub(-1) ~= '/' then
      path = path..'/'
   end
   local pipe = io.popen('ls '..path..' 2> /dev/null')
   local output = pipe:read'*a'
   pipe:close()
   -- If your file names contain national characters
   -- output = convert_OEM_to_ANSI(output)
   local files = {}
   for filename in output:gmatch('[^\n]+') do
      if prepend_path_to_filenames then
         filename = path..filename
      end
      table.insert(files, filename)
   end
   return files
end

-- A test to show how it works
local array_of_files = get_files(arg[1], false)
for _, fn in ipairs(array_of_files) do
   print(fn)
end

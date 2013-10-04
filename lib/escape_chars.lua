#!/usr/bin/env lua

---
-- @author Gianluca Fiore
-- @copyright 2013, Gianluca Fiore <forod.g@gmail.com>
--

--- Escape problematic characters in a string
--@param s the string containing the characters to be escaped
function escape(s)
	return (s:gsub("[%-%.%+%[%]%(%)%$%^%%%?%*%'", '%%%1'):gsub('%z', '%%z'))
end

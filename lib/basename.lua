-- Copyright 2011-2013, Gianluca Fiore © <forod.g@gmail.com>

--- Function equivalent to basename in POSIX systems
--@param str the path string
function basename(str)
	local name = string.gsub(str, "(.*/)(.*)", "%2")
	return name
end

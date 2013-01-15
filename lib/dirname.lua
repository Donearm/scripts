-- Copyright 2011-2013, Gianluca Fiore © <forod.g@gmail.com>

--- Function equivalent to dirname in POSIX systems
--@param str the path string
function dirname(str)
	local name = string.gsub(str, "(.*/)(.*)", "%1")
	return name
end

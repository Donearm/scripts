#!/usr/bin/env lua

-- Copyright 2011-2014, Gianluca Fiore © <forod.g@gmail.com>
--
local c = os.clock()
local s = 0
for i=1,1000000 do s = s + 1 end

-- insert code here

print(string.format("elapsed time: %.2f\n", os.clock() - c))

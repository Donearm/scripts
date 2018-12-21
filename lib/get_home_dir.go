package main

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018, Gianluca Fiore
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
////////////////////////////////////////////////////////////////////////////////

// Get current user's home directory. Works on Windows/Darwin/Linux
import (
	"os/user"
	"fmt"
)

func main() {
	u, err := user.Current()
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(u.HomeDir)
}

package main

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2015, Gianluca Fiore
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
////////////////////////////////////////////////////////////////////////////////

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"
)

const sopcast string = "sp-sc"
const player string = "mpv"

// Helper functions
func printCommand(cmd *exec.Cmd) {
	fmt.Printf("--> Executing: %s\n", strings.Join(cmd.Args, " "))
}

func printError(err error) {
	os.Stderr.WriteString(fmt.Sprintf("--> Error: %s\n", err.Error()))
}

func main() {
	// Launch Sopcast
	sopcastCmd := exec.Command(sopcast, os.Args[1], "3908", "8908", "> /dev/null")

	err := sopcastCmd.Start()
	if err != nil {
		printError(err)
		os.Exit(1)
	} else {
		printCommand(sopcastCmd)
		if err != nil {
			printError(err)
		}
	}

	// sleep a bit to allow Sopcast to start caching the stream to an amount
	// that the player can reproduce without bailing out because cache is too
	// small
	time.Sleep(5 * time.Second)

	// Launch the video player
	playerCmd := exec.Command(player, "http://localhost:8908/tv.asf")
	err = playerCmd.Start()
	if err != nil {
		printError(err)
		// There has been an error with the video player, exit but kill Sopcast 
		// first
		err := sopcastCmd.Process.Signal(os.Kill)
		if err != nil {
			printError(err)
		} else {
			os.Exit(1)
		}
	} else {
		printCommand(playerCmd)
		err = playerCmd.Wait()
		if err != nil {
			printError(err)
		}
		// Kill Sopcast process before exiting
		_ = sopcastCmd.Process.Signal(os.Kill)
	}
	os.Exit(0)
}

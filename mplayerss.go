package main

/*
* Kill xscreensaver, cairo-compmgr and/or compton before running
* mplayer and reactivate them after mplayer exits
* @author Gianluca Fiore
* @copyright 2014, Gianluca Fiore <forod.g@gmail.com>
 */

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"syscall"
)

// Listing all possible app here as it's quicker to change them if using a
// different program to accomplish the same things (like MPlayer/SMPlayer)
const mplayerCmd string = "mpv"
const screensaverCmd string = "xscreensaver"
const cairoCmd string = "cairo-compmgr"
const comptonCmd string = "compton"

func getPidOf(command string) string {
	pidBytes := exec.Command("ps", "-o", "pid=", "-C", command)
	out, err := pidBytes.Output()
	if err != nil {
		if len(out) == 0 {
			// if out is empty, the process isn't running. Return empty string
			return ""
		} else {
			panic(err)
		}
	}

	// Use a new []byte to contain the numerical only output of the ps command
	var finalPid []byte
	for _, x := range out {
		// if it's between 48 and 57 in the ASCII table, it's a number. Ignore
		// the rest (usually a space at the beginning and a trailing newline
		// symbols)
		if x > 47 && x < 58 {
			finalPid = append(finalPid, x)
		}
	}
	// convert []byte (pidBytes) to string
	/*	pid := string(out[1:len(out)-1]) */
	pid := string(finalPid)
	return pid
}

func deactivateScreensaver() {
	screensaverPidStr := getPidOf(screensaverCmd)
	// string -> int
	if screensaverPidStr != "" {
		screensaverPid, err := strconv.Atoi(screensaverPidStr)
		if err != nil {
			panic(err)
		}
		if err := syscall.Kill(screensaverPid, 0); err != nil {
			// not running, just exit
			fmt.Println("Xscreensaver is not running")
			return
		} else {
			// Kill it then
			fmt.Println("Xscreensaver is running")
			cmd := exec.Command(screensaverCmd, "-deactivate", ">&-", "2>&- &")
			startErr := cmd.Start()
			if startErr != nil {
				panic(startErr)
			}
		}
	} else {
		return
	}
}

func dpmsControl(action bool) {
	// true means enable, false disable
	if action {
		dpmsCmd1 := exec.Command("xset", "+dpms")
		startErr := dpmsCmd1.Start()
		if startErr != nil {
			panic(startErr)
		}
		dpmsCmd2 := exec.Command("xset", "s", "on")
		startErr = dpmsCmd2.Start()
		if startErr != nil {
			panic(startErr)
		}
	} else {
		dpmsCmd1 := exec.Command("xset", "-dpms")
		startErr := dpmsCmd1.Start()
		if startErr != nil {
			panic(startErr)
		}
		dpmsCmd2 := exec.Command("xset", "s", "off")
		startErr = dpmsCmd2.Start()
		if startErr != nil {
			panic(startErr)
		}
	}
}

func compositingControl(action string, manager string) {
	if action == "kill" {
		managerPidStr := getPidOf(manager)
		// string -> int
		if managerPidStr != "" {
			managerPid, err := strconv.Atoi(managerPidStr)
			if err != nil {
				panic(err)
			}
			killErr := syscall.Kill(managerPid, 9)
			if killErr != nil {
				panic(killErr)
			}
		} else {
			// the composite manager might not be running after all
			return
		}
	} else if action == "activate" {
		var activateCmd *exec.Cmd
		if manager == "cairo" {
			activateCmd = exec.Command(cairoCmd)
		} else if manager == "compton" {
			// full path here
			activateCmd = exec.Command(comptonCmd, "--config", "/home/gianluca/.config/compton.conf")
		} else {
			return
		}

		printCmdStderr(activateCmd)
	}
}

func printCmdStderr(cmd *exec.Cmd) {
	var out, stderr bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = &stderr

	startErr := cmd.Start()
	if startErr != nil {
		fmt.Println(fmt.Sprint(startErr) + ": " + stderr.String())
	}
}

func main() {
	// Disable the current composite manager
	compositingControl("kill", "compton")
	// Disable dpms and screensaver
	dpmsControl(false)
	//deactivateScreensaver()

	// Launch MPlayer
	cmd := exec.Command(mplayerCmd, os.Args[1])
	startErr := cmd.Start()
	if startErr != nil {
		panic(startErr)
	}
	waitErr := cmd.Wait()
	if waitErr != nil {
		panic(waitErr)
	}

	// Re-enable the composite manager
	compositingControl("activate", "compton")
	// Re-enable dpms and screensaver
	dpmsControl(true)

	os.Exit(0)
}

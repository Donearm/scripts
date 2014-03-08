/* Imgdb.go
/
/ Copyright (c) 2014, Gianluca Fiore
/
/    This program is free software: you can redistribute it and/or modify
/    it under the terms of the GNU General Public License as published by
/    the Free Software Foundation, either version 3 of the License, or
/    (at your option) any later version.
/
/ Requirements: Go, go-sqlite3
/
/ What's for:
/		Nothing, actually. I just wanted to play with Go and SQLite :-)
/		Feel free to improve/hack/fork/pull request this.
/
*/

package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"math/rand"
	"os"
	"path/filepath"
	"regexp"
	"time"

	_ "github.com/mattn/go-sqlite3"
)

var createArg bool		// Create the db flag
var updateArg bool		// Just update the db flag
var usedArg bool		// Used state for a db row flag
var insensitiveArg bool // Case insensitive search flag
var randomArg bool		// Random image flag
var searchArg string	// Search string flag

var usageMessage string = `
imgdb.go [options] [imgpath]

Description:
imgdb.go will create anew or update a pre-existing database of file paths in 
a specific filesystem location. Every file will have a "used" column in 
the database to tell whether it has already been used or not. 
Implemented also are searching the database and printing a random image, 
among the ones that haven't yet been used.

Arguments:
	-help|-h
		This help
	-create|-c
		Create the database
	-update|-u
		Just update the database with new files and removing old ones
	-used|-d
		Change the used state of a row in the database
	-random|-r
		Print a random image's path
	-search|-s <string>
		Search for a string, usually part of the path or the image name, 
		in the database
	-insensitive|-i
		Search in case insensitive mode. It requires also -s (obviously)

`

// Init flags
func flagsInit() {
	const (
		flagCreate		= false
		flagUpdate		= false
		flagUsed		= false
		flagInsensitive	= false
		flagRandom		= false
		flagSearch		= ""
	)

	flag.Usage = func() {
		fmt.Fprintf(os.Stderr, usageMessage)
	}

	flag.BoolVar(&createArg, "create", flagCreate, "")
	flag.BoolVar(&createArg, "c", flagCreate, "")
	flag.BoolVar(&updateArg, "update", flagUpdate, "")
	flag.BoolVar(&updateArg, "u", flagUpdate, "")
	flag.BoolVar(&usedArg, "used", flagUsed, "")
	flag.BoolVar(&usedArg, "d", flagUsed, "")
	flag.BoolVar(&insensitiveArg, "insensitive", flagInsensitive, "")
	flag.BoolVar(&insensitiveArg, "i", flagInsensitive, "")
	flag.BoolVar(&randomArg, "random", flagRandom, "")
	flag.BoolVar(&randomArg, "r", flagRandom, "")
	flag.StringVar(&searchArg, "search", flagSearch, "")
	flag.StringVar(&searchArg, "s", flagSearch, "")

	flag.Parse()
}

// Make sure that the db actually exists
func pathExists(path string) (bool, error) {
	_, err := os.Stat(path)
	if err == nil {
		return true, nil
	}
	if os.IsNotExist(err) {
		return false, nil
	}
	return false, err
}

// Connect to the db and return a pointer to it
func connectDb(dbpath string) *sql.DB {
	e, err := pathExists(dbpath)
	if e != true {
		if err != nil {
			log.Fatal(err)
		}
	}
	// Connect
	db, err := sql.Open("sqlite3", dbpath)
	if err != nil {
		log.Fatal(err)
	}
	return db
}

// Create the db
func createDb(db *sql.DB) *sql.DB {
	// Create
	sql := `
	create table if not exists images (id integer not null primary key, 
	path text unique, 
	used integer default 0);
	`
	_, err := db.Exec(sql)
	if err != nil {
		log.Printf("%q: %s\n", err, sql)
		db.Close()
		log.Fatal(err)
	}
	return db
}

// Save file list from a path in a map
func saveFileList(path string) []string {
	var pathmaps []string // map of paths to add to the db

	// Check the path exists
	if _, err := os.Stat(path); err != nil {
		log.Fatal(err)
	}

	visit := func(path string, f os.FileInfo, err error) error {
		if f.IsDir() != true {
			pathmaps = append(pathmaps, path)
		}
		return nil
	}
	err := filepath.Walk(path, visit)
	if err != nil {
		fmt.Fprintf(os.Stderr, "filepath.Walk() returned %v\n", err)
	}
	return pathmaps
}

// Purge deleted files from the database and add new ones to it
func updateDb(db *sql.DB, pathmaps []string) {
	currentRows := make(map[string]int) // current paths present in db
	rows, err := db.Query("select path, used from images")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	// Build a map of current paths in the db
	for rows.Next() {
		var path string
		var used int
		rows.Scan(&path, &used)
		currentRows[path] = used
	}

	for _, v := range pathmaps {
		found := false
		for k, _ := range currentRows {
			if v == k {
				found = true
				break
			}
		}
		if !found {
			fmt.Println("Found a new image ", v)
			addRow(db, v, 0)
		}
	}

	for k, _ := range currentRows {
		toDelete := true
		for _, v := range pathmaps {
			if k == v {
				toDelete = false
				break
			}
		}
		if toDelete {
			fmt.Println("Deleting ", k)
			_, err = db.Exec("delete from images where path=?", k)
			if err != nil {
				log.Fatal(err)
			}
		}
	}
}

// Query the db with the search string
func searchRow(db *sql.DB, query string) map[string]int {
	var currentPath string					// Scanned rows' path
	var currentUsed int					// Scanned rows' used status
	matchingPaths := make(map[string]int) // Map of paths matching the query
	// along with used status integers being the keys

	r, err := regexp.Compile(query)
	if err != nil {
		fmt.Fprintf(os.Stderr, "There is a problem with the search string, sorry\n")
		return matchingPaths
	}
	// We got to select ALL paths as the user most probably isn't going
	// to search with a full path string but just with part of the
	// filename. Therefore, it won't match any row.
	rows, err := db.Query("select path, used from images")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
		rows.Scan(&currentPath, &currentUsed)
		if r.MatchString(currentPath) == true {
			matchingPaths[currentPath] = currentUsed
		}
	}
	return matchingPaths
}

// Change the used column in the db for the given paths
func changeUsedState(db *sql.DB, path string) {
	_, err := db.Exec(`update images set 
	used = case when used=0 then 1 else 0 end where path = ?`, path)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("Updated used status for ", path)
}

// Print a random image's path
func printRandomPath(db *sql.DB) {
	// Get current number of rows present
	var totalRows int
	err := db.QueryRow("select count(*) from images").Scan(&totalRows)
	switch {
	case err == sql.ErrNoRows:
		log.Printf("Couldn't get total number of rows in database, perhaps it is empty?")
	case err != nil:
		log.Fatal(err)
	default:
		fmt.Println(rand.Intn(totalRows))
	}

	randomPath, err := db.Query("select path, used from images where id=?", rand.Intn(totalRows))
	if err != nil {
		log.Fatal(err)
	}
	defer randomPath.Close()
	for randomPath.Next() {
		var path string
		var used int
		randomPath.Scan(&path, &used)
		if used == 1 {
			// We have already used this image, we want a fresh one
			printRandomPath(db)
		} else {
			fmt.Println(path)
		}
	}
}

// Add a row (id, path, used) to the db
func addRow(db *sql.DB, path string, used int) {
	// Add
	tx, err := db.Begin()
	if err != nil {
		log.Fatal(err)
	}

	statement, err := tx.Prepare("insert into images(path, used) values(?, ?)")
	if err != nil {
		log.Fatal(err)
	}
	defer statement.Close()
	_, err = statement.Exec(path, used)
	if err != nil {
		// The row is already present, skip it
		return
	}
	tx.Commit()

	// Select
	rows, err := db.Query("select id, path, used from images")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var id int
		var path string
		var used int
		rows.Scan(&id, &path, &used)
	}
}

func main() {
	dbpath := "/mnt/c/img.db"				// path of the db
	rand.Seed(time.Now().UTC().UnixNano())	// Initialize random seed

	flagsInit()
	imgpath := flag.Arg(0) // path of the images
	if imgpath == "" {
		// default to below if we didn't give it as an argument
		imgpath = "/media/private/img/Models/"
	}

	pathmaps := saveFileList(imgpath)

	if searchArg != "" {
		db := connectDb(dbpath)
		if insensitiveArg { // Perform a case insensitive search
			searchArg = `(?i)` + searchArg
		}
		rslt := searchRow(db, searchArg)
		if len(rslt) > 0 {
			fmt.Println("We found these matching images\n")
			for p, i := range rslt {
				fmt.Println(p, i)
				if usedArg { // Change used status then
					changeUsedState(db, p)
				}
			}
		} else {
			fmt.Println("Sorry, nothing found")
		}
		db.Close()
	} else if randomArg {
		db := connectDb(dbpath)
		printRandomPath(db)
		db.Close()
	} else if updateArg {
		db := connectDb(dbpath)
		fmt.Printf("There are currently a total of %d images in the database\n", len(pathmaps))
		updateDb(db, pathmaps)
		db.Close()
	} else if createArg {
		db := createDb(connectDb(dbpath))

		for _, f := range pathmaps {
			addRow(db, f, 0)
		}
		fmt.Println("Database created")
		db.Close()
	} else {
		flag.Usage()
	}
}

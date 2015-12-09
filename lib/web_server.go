package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
)

var path = flag.String("path", "", "custom path to load the static assets")
var port = flag.Int("port", 8484, "port used by the webserver")
var verb = flag.Bool("verbose", false, "be verbose")

func main() {
	flag.Parse()
	var staticPath string
	var err error
	if *path != "" {
		staticPath = *path
	} else {
		staticPath, err = filepath.Abs("public")
		if err != nil {
			log.Fatal(err)
		}
	}
	if _, err := os.Stat(staticPath); os.IsNotExist(err) {
		fmt.Printf("This server is trying to serve static content from: \n%s\nbut this folder doesn't exist, please create it or pass a 'path' argument when starting the server.", staticPath)
		fmt.Printf("To create a folder from the command line, type: mkdir public\n")
	}
	if *verb {
		log.Printf("About to start the server on port %d\nServing content from %s", *port, staticPath)
		log.Println("Put your files inside the public folder and they will available via")
		log.Printf("http://localhost:%d\n", *port)
		log.Println("Then open the same address in your browser")
	}
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", *port), http.FileServer(http.Dir(staticPath))))
}

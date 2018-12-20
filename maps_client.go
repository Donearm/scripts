package main

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2017-2018, Gianluca Fiore
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
////////////////////////////////////////////////////////////////////////////////

// Query the Google Maps API for results matching a specific category of places around Krakow.
// This was a base for a full web app that never saw the light

import (
	"flag"
	"log"
	"fmt"
	"os"
	"time"
	"bytes"

	"encoding/csv"

	"googlemaps.github.io/maps"
	"golang.org/x/net/context"
)

const (
	version float64 = 0.1
)

var api_key string
var search_name string

func init() {

	flag.StringVar(&api_key, "apikey", " ", "the api key for Google Maps")
	flag.StringVar(&api_key, "a", " ", "the api key for Google Maps")
	flag.StringVar(&search_name, "search", " ", "search query for Maps")
	flag.StringVar(&search_name, "s", " ", "search query for Maps")

	flag.Parse()
}


func JsonToCsv(s string, r ...maps.PlacesSearchResponse) {

	// creatte a buffer to concatenate the result's filename to
	var buffer bytes.Buffer
	buffer.WriteString(s)
	buffer.WriteString("-results.csv")

	// Create an output csv file
	f, err := os.Create(buffer.String())
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	// Create a csv writer
	w := csv.NewWriter(f)
	// if multiple responses given, iterate on them all
	for _, params := range r {
		for _, obj := range params.Results {
			var record []string
			latitude := fmt.Sprintf("%.4f", obj.Geometry.Location.Lat)
			longitude := fmt.Sprintf("%.4f", obj.Geometry.Location.Lng)
			record = append(record, obj.Name, obj.FormattedAddress, latitude, longitude)
			w.Write(record)
		}
		w.Flush()
	}
}


func main() {
	Krakow := &maps.LatLng{50.06, 19.94}


	c, err := maps.NewClient(maps.WithAPIKey(api_key))
	if err != nil {
		log.Fatal("error! %s", err)
	}

	var txtresp, txtresp2, txtresp3 maps.PlacesSearchResponse

	txtr := &maps.TextSearchRequest{
		Query: search_name,
		Location: Krakow,
		Radius: 20000,
		Language: "english"}

	txtresp, err = c.TextSearch(context.Background(), txtr)
	if err != nil {
		log.Fatal("error while doing a Text Search on Maps: %s", err)
	}

	// Check if there are more than 20 results by checking the NextPageToken 
	// existence. Up to 3 pages for up to 60 results.
	// Long break between the next request as otherwise Maps API reply with 
	// "INVALID REQUEST" as there needs to be given time to the NextPageToken to 
	// be generated
	//
	// Yes it is ugly. Yes it works.
	//
	if len(txtresp.NextPageToken) > 0 {
		time.Sleep(10000 * time.Millisecond)
		txtr2 := &maps.TextSearchRequest{
			PageToken: txtresp.NextPageToken}

		txtresp2, err = c.TextSearch(context.Background(), txtr2)
		if err != nil {
			log.Fatal("error while doing a Text Search2 on Maps: %s", err)
		}
		if len(txtresp2.NextPageToken) > 0 {
			time.Sleep(10000 * time.Millisecond)
			txtr3 := &maps.TextSearchRequest{
				PageToken: txtresp2.NextPageToken}

			txtresp3, err = c.TextSearch(context.Background(), txtr3)
			if err != nil {
				log.Fatal("error while doing a Text Search3 on Maps: %s", err)
			}
		}
	}

	JsonToCsv(search_name, txtresp, txtresp2, txtresp3)
}

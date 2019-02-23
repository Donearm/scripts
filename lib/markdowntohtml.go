package main

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, Gianluca Fiore
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
////////////////////////////////////////////////////////////////////////////////

// Given an input files, it uses Commonmark Golang Markdown parser to analyze it 
// and output a HTML file


import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
	"gitlab.com/golang-commonmark/markdown"
)

// the input file
const doc = "README.md"

// open input files and return a slice of bytes
func readFromFile(fn string) ([]byte, error) {
	f, err := os.Open(fn)
	if err != nil {
		return nil, err
	}
	defer f.Close()

	return ioutil.ReadAll(f)
}

// extract text from each Markdown tokens, recursively
func extractText(tok markdown.Token) string {
	switch tok := tok.(type) {
	case *markdown.Text:
		return tok.Content
	case *markdown.Inline:
		text := ""
		for _, tok := range tok.Children {
			text += extractText(tok)
		}
		return text
	}
	return ""
}

func main() {
	var title, rendererOutput string

	data, err := readFromFile(doc)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	md := markdown.New()

	tokens := md.Parse(data)
	if len(tokens) > 0 {
		if heading, ok := tokens[0].(*markdown.HeadingOpen); ok {
			for i := 1; i < len(tokens); i++ {
				if tok, ok := tokens[i].(*markdown.HeadingClose); ok && tok.Lvl == heading.Lvl {
					break
				}
				title += extractText(tokens[i])
			}
			title = strings.TrimSpace(title)
		}
	}

	rendererOutput = md.RenderTokensToString(tokens)
	fmt.Print(rendererOutput)
}


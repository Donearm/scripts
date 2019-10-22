// Panic on any error
func check(e error) {
	if e != nil {
		panic(e)
	}
}

// return home directory of current user
func returnHomeDir() string {
	if homedir := os.Getenv("HOMEPATH"); homedir != "" {
		return homedir
	} else if homedir := os.Getenv("HOME"); homedir != "" {
		return homedir
	} else {
		return ""
	}
}

// return filename without the extension
func basename(path string) string {
	basename := filepath.Base(path)
	return strings.TrimSuffix(basename, filepath.Ext(basename))
}

// Print text in bold on terminal
func bold(t string) string {
	return "\033[1m" + t + "\033[0m"
}

// return the type of any object (as a string)
func typeOf(v interface{}) string {
	return fmt.Sprintf("%T", v)
}

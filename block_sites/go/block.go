package main

import (
	"io/ioutil"
	"os"
	"regexp"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func block() {
	dat, err := ioutil.ReadFile("./testhosts")
	check(err)

	fileStr := string(dat)

	lines := strings.Split(fileStr, "\n")

	blockedSitesSection := false

	var nextLines []string

	for _, line := range lines {
		line = strings.Trim(line, " ")
		if regexp.MustCompile(`blocked\ssites\sstart`).MatchString(line) {
			blockedSitesSection = true
		}

		if regexp.MustCompile(`blocked\ssites\send`).MatchString(line) {
			blockedSitesSection = false
		}

		if blockedSitesSection && regexp.MustCompile(`^\s*#+\s*127\.0\.0\.1`).MatchString(line) {
			line = regexp.MustCompile(`^#+\s*`).ReplaceAllString(line, "")
		}

		nextLines = append(nextLines, line)
	}

	f, err := os.Create("./testhosts")
	check(err)

	defer f.Close()

	_, err = f.WriteString(strings.Join(nextLines, "\n"))

	if err != nil {
		return
	}
}

func main() {
	block()
}

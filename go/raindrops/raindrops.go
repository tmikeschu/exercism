// Package raindrops takes numbers and converts them to (some times special) strings!
package raindrops

import "strconv"

// Convert takes a string and returns a keyword or the number as a string.
func Convert(a int) string {
	final := ""

	if a%3 == 0 {
		final += "Pling"
	}
	if a%5 == 0 {
		final += "Plang"
	}
	if a%7 == 0 {
		final += "Plong"
	}

	if final == "" {
		final = strconv.Itoa(a)
	}

	return final
}

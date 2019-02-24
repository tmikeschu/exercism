// Package hamming provides the distance of two protein strands
package hamming

import (
	e "errors"
	s "strings"
)

// Distance takes two protein strands and determines their "distance" apart.
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return 0, e.New("invalid strings")
	}

	aChars := s.Split(a, "")
	bChars := s.Split(b, "")
	distance := 0

	for index, letter := range aChars {
		if letter != bChars[index] {
			distance = distance + 1
		}
	}

	return distance, nil
}

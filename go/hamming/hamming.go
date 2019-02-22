// Package hamming provides the distance of two protein strands
package hamming

import (
	e "errors"
	// s "strings"
)

// Distance takes two protein strands and determines their "distance" apart.
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return 0, e.New("invalid strings")
	}

	// avg benchmark ~ 1.7 seconds
	return distance(a, b, 0), nil

	/* slower implementation, avg benchmark for test suite ~ 2.7 seconds

	aChars := s.Split(a, "")
	bChars := s.Split(b, "")
	distance := 0

	for index, letter := range aChars {
		if letter != bChars[index] {
			distance = distance + 1
		}
	}

	return distance, nil
	*/
}

func distance(a, b string, d int) int {
	if len(a) == 0 {
		return d
	}

	a1, aTail := headTail(a)
	b1, bTail := headTail(b)

	if a1 != b1 {
		return distance(aTail, bTail, d+1)
	}
	return distance(aTail, bTail, d)

	/* slower implementation, not sure why?, avg benchmark 1.8 seconds
	inc := 0
	if a1 != b1 {
		inc = 1
	}
	return distance(aTail, bTail, d + inc)
	*/
}

func headTail(s string) (byte, string) {
	return s[0], s[1:]
}

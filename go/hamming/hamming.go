// Package hamming provides the distance of two protein strands
package hamming

import (
	e "errors"
)

// Distance takes two protein strands and determines their "distance" apart.
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return 0, e.New("invalid strings")
	}

	return distance(a, b, 0), nil
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
}

func headTail(s string) (byte, string) {
	return s[0], s[1:]
}

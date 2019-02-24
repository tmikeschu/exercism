// Package raindrops takes numbers and converts them to (some times special) strings!
package raindrops

import "strconv"

// Convert takes a string and returns a keyword or the number as a string.
func Convert(a int) string {
	converters := []func(int) string{
		modConverter(3, "Pling"),
		modConverter(5, "Plang"),
		modConverter(7, "Plong")}

	final := ""

	for _, c := range converters {
		conversion := c(a)
		if conversion != "" {
			final = final + conversion
		}
	}

	if final == "" {
		final = strconv.Itoa(a)
	}
	return final
}

func modConverter(i int, s string) func(int) string {
	return func(x int) string {
		if x%i == 0 {
			return s
		}
		return ""
	}
}

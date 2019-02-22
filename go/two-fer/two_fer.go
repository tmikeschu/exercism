// Package twofer is builds nice string messages about sharing.
package twofer

// ShareWith takes a name input, which will be resolved to "you" if the input is empty.
func ShareWith(name string) string {
	recipient := defaultRecipient(name)

	return "One for " + recipient + ", one for me."
}

func defaultRecipient(name string) string {
	if len(name) == 0 {
		return "you"
	}
	return name
}

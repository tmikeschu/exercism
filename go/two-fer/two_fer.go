/*
Package twofer has one public function: ShareWith.
It returns a nice little string, with "you" as the default recipient.
*/

package twofer

import s "strings"

// ShareWith takes a name input, which will be resolved to "you" if the input is empty.
func ShareWith(name string) string {
	recipient := defaultRecipient(name)

	return s.Join([]string{"One for ", recipient, ", one for me."}, "")
}

func defaultRecipient(name string) string {
	if len(name) == 0 {
		return "you"
	} else {
		return name
	}
}

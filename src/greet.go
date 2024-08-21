package greet

import "fmt"

// Hello will compose a Hello message
func Hello(name string) string {
	return fmt.Sprintf("Hello, %s!", name)
}

package greet

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestHello(t *testing.T) {
	a := assert.New(t)
	hello := Hello("John")

	a.Equal("Hello, John!", hello)
}

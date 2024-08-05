package arrayutils

import (
	"reflect"
	"testing"
)

func TestDifferenceBothEmpty(t *testing.T) {
	a := []string{}
	b := []string{}
	expected := []string{}

	result := Difference(a, b)
	if !reflect.DeepEqual(result, expected) {
		t.Errorf("Difference(%v, %v) = %v; expected %v", a, b, result, expected)
	}
}

func TestDifferenceAEmpty(t *testing.T) {
	a := []string{}
	b := []string{"apple", "banana"}
	expected := []string{}

	result := Difference(a, b)
	if !reflect.DeepEqual(result, expected) {
		t.Errorf("Difference(%v, %v) = %v; expected %v", a, b, result, expected)
	}
}

func TestDifferenceBEmpty(t *testing.T) {
	a := []string{"apple", "banana"}
	b := []string{}
	expected := []string{"apple", "banana"}

	result := Difference(a, b)
	if !reflect.DeepEqual(result, expected) {
		t.Errorf("Difference(%v, %v) = %v; expected %v", a, b, result, expected)
	}
}

func TestDifferenceNoDifference(t *testing.T) {
	a := []string{"apple", "banana"}
	b := []string{"apple", "banana"}
	expected := []string{}

	result := Difference(a, b)
	if !reflect.DeepEqual(result, expected) {
		t.Errorf("Difference(%v, %v) = %v; expected %v", a, b, result, expected)
	}
}

func TestDifferenceSomeDifference(t *testing.T) {
	a := []string{"apple", "banana", "cherry"}
	b := []string{"banana"}
	expected := []string{"apple", "cherry"}

	result := Difference(a, b)
	if !reflect.DeepEqual(result, expected) {
		t.Errorf("Difference(%v, %v) = %v; expected %v", a, b, result, expected)
	}
}

func TestDifferenceAllDifferent(t *testing.T) {
	a := []string{"apple", "banana"}
	b := []string{"cherry", "date"}
	expected := []string{"apple", "banana"}

	result := Difference(a, b)
	if !reflect.DeepEqual(result, expected) {
		t.Errorf("Difference(%v, %v) = %v; expected %v", a, b, result, expected)
	}
}

func TestDifferenceWithDuplicatesInA(t *testing.T) {
	a := []string{"apple", "apple", "banana"}
	b := []string{"banana"}
	expected := []string{"apple", "apple"}

	result := Difference(a, b)
	if !reflect.DeepEqual(result, expected) {
		t.Errorf("Difference(%v, %v) = %v; expected %v", a, b, result, expected)
	}
}

func TestDifferenceWithDuplicatesInB(t *testing.T) {
	a := []string{"apple", "banana"}
	b := []string{"banana", "banana"}
	expected := []string{"apple"}

	result := Difference(a, b)
	if !reflect.DeepEqual(result, expected) {
		t.Errorf("Difference(%v, %v) = %v; expected %v", a, b, result, expected)
	}
}

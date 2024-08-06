package arrayutils

import "testing"

func TestContainsItemPresent(t *testing.T) {
	slice := []string{"apple", "banana", "cherry"}
	item := "banana"
	expected := true

	result := Contains(slice, item)
	if result != expected {
		t.Errorf("Contains(%v, %s) = %v; expected %v", slice, item, result, expected)
	}
}

func TestContainsItemAbsent(t *testing.T) {
	slice := []string{"apple", "banana", "cherry"}
	item := "grape"
	expected := false

	result := Contains(slice, item)
	if result != expected {
		t.Errorf("Contains(%v, %s) = %v; expected %v", slice, item, result, expected)
	}
}

func TestContainsEmptySlice(t *testing.T) {
	slice := []string{}
	item := "banana"
	expected := false

	result := Contains(slice, item)
	if result != expected {
		t.Errorf("Contains(%v, %s) = %v; expected %v", slice, item, result, expected)
	}
}

func TestContainsSingleItemPresent(t *testing.T) {
	slice := []string{"banana"}
	item := "banana"
	expected := true

	result := Contains(slice, item)
	if result != expected {
		t.Errorf("Contains(%v, %s) = %v; expected %v", slice, item, result, expected)
	}
}

func TestContainsSingleItemAbsent(t *testing.T) {
	slice := []string{"banana"}
	item := "apple"
	expected := false

	result := Contains(slice, item)
	if result != expected {
		t.Errorf("Contains(%v, %s) = %v; expected %v", slice, item, result, expected)
	}
}

func TestContainsMultipleItemsPresent(t *testing.T) {
	slice := []string{"apple", "banana", "cherry", "date", "fig"}
	item := "date"
	expected := true

	result := Contains(slice, item)
	if result != expected {
		t.Errorf("Contains(%v, %s) = %v; expected %v", slice, item, result, expected)
	}
}

func TestContainsMultipleItemsAbsent(t *testing.T) {
	slice := []string{"apple", "banana", "cherry", "date", "fig"}
	item := "kiwi"
	expected := false

	result := Contains(slice, item)
	if result != expected {
		t.Errorf("Contains(%v, %s) = %v; expected %v", slice, item, result, expected)
	}
}

package arrayutils

func Difference(a, b []string) []string {
	var diff []string
	for _, item := range a {
		if !Contains(b, item) {
			diff = append(diff, item)
		}
	}
	return diff
}

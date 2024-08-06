package apps

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"path/filepath"

	"github.com/dragoscirjan/configs/src/arrayutils"
)

type App struct {
	Name       string              `json:"name"`
	Type       string              `json:"type"`
	Default    bool                `json:"default"`
	Installers map[string][]string `json:"installers"`
}

var AppsJsonPath = filepath.Join(filepath.Dir(os.Args[0]), "apps.json")

func readAppsJSON() ([]App, error) {
	file, err := os.Open(AppsJsonPath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	byteValue, err := io.ReadAll(file)
	if err != nil {
		return nil, err
	}

	var apps []App
	json.Unmarshal(byteValue, &apps)
	return apps, nil
}

// GetApps Convert the apps.json file into an App array
func GetApps() ([]App, error) {
	apps, err := readAppsJSON()
	if err != nil {
		return nil, err
	}

	return apps, nil
}

// GetAppTypes will list all the apps.json types as a string array
func GetAppTypes() ([]string, error) {
	var types []string
	var apps, err = GetApps()
	if err != nil {
		return nil, err
	}

	for _, app := range apps {
		if !arrayutils.Contains(types, app.Type) {
			types = append(types, app.Type)
		}
	}

	return types, nil
}

// GetAppsByType returns all the apps in the given type
func GetAppsByType(appsType string) ([]App, error) {
	apps, err := GetApps()
	if err != nil {
		return nil, err
	}

	var filteredApps []App
	for _, app := range apps {
		if app.Type == appsType {
			filteredApps = append(filteredApps, app)
		}
	}

	return filteredApps, nil
}

// GetAppsByTypeAndNamesSubset returns a list of App objects matching the specified app
// type and app names as a slice of App objects
func GetAppsByTypeAndNamesSubset(appsType string, names []string) ([]App, error) {
	apps, err := GetApps()
	if err != nil {
		return nil, err
	}

	nameSet := make(map[string]struct{})
	for _, name := range names {
		nameSet[name] = struct{}{}
	}

	var filteredApps []App
	for _, app := range apps {
		if app.Type == appsType {
			if _, exists := nameSet[app.Name]; exists {
				filteredApps = append(filteredApps, app)
			}
		}
	}

	var filteredAppsNames = AppsToNames(filteredApps)
	if diff := arrayutils.Difference(names, filteredAppsNames); len(diff) > 0 {
		return nil, fmt.Errorf("the following names were not found: %v", diff)
	}

	return filteredApps, nil
}

// AppsToNames returns the names of the apps as a slice of strings
func AppsToNames(apps []App) []string {
	var names []string

	for _, app := range apps {
		names = append(names, app.Name)
	}

	return names
}

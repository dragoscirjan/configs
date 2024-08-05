package apps

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
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

	byteValue, err := ioutil.ReadAll(file)
	if err != nil {
		return nil, err
	}

	var apps []App
	json.Unmarshal(byteValue, &apps)
	return apps, nil
}

func GetAppsByType(appsType string) ([]string, error) {
	apps, err := readAppsJSON()
	if err != nil {
		return nil, err
	}

	var filteredApps []string
	for _, app := range apps {
		if app.Type == appsType {
			filteredApps = append(filteredApps, app.Name)
		}
	}

	return filteredApps, nil
}

func GetAppsByTypeAndNamesSubset(appsType string, names []string) ([]string, error) {
	apps, err := readAppsJSON()
	if err != nil {
		return nil, err
	}

	nameSet := make(map[string]struct{})
	for _, name := range names {
		nameSet[name] = struct{}{}
	}

	var filteredApps []string
	for _, app := range apps {
		if app.Type == appsType {
			if _, exists := nameSet[app.Name]; exists {
				filteredApps = append(filteredApps, app.Name)
			}
		}
	}

	if diff := arrayutils.Difference(names, filteredApps); len(diff) > 0 {
		return nil, fmt.Errorf("the following names were not found: %v", diff)
	}

	return filteredApps, nil
}

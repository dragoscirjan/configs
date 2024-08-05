package main

import (
    // "bufio"
    // "encoding/json"
    // "fmt"
    // "os"
    // "os/exec"
    // "path/filepath"
    // "sort"
    // "strings"
    // "time"
)

var (
    scriptDir      string
    scriptName     string
    scriptVersion  string
    scriptAppsList string = "./apps.json"
    timestamp      string
    osType         string
    osInstallers   []string
    preferredInstallers []string
    appTypes       []string
    appList        []string
)

type App struct {
    Name       string            `json:"name"`
    Type       string            `json:"type"`
    Default    bool              `json:"default"`
    Installers map[string][]string `json:"installers"`
}

// func initVariables() {
//     scriptDir = filepath.Dir(os.Args[0])
//     scriptName = filepath.Base(os.Args[0])
//     timestamp = time.Now().Format("20060102150405")
//     osInstallers = []string{"brew"}
// }

// func determineOSType() {
//     if fileExists("/etc/lsb-release") {
//         osType = getFileContent("/etc/lsb-release", "DISTRIB_ID")
//         osInstallers = []string{"snap", "apt"}
//     } else if fileExists("/etc/debian_version") {
//         osType = "debian"
//         osInstallers = []string{"snap", "apt"}
//     } else {
//         osType = "darwin"
//         osInstallers = []string{"brew"}
//     }
// }

// func getFileContent(filePath, key string) string {
//     file, err := os.Open(filePath)
//     if err != nil {
//         fmt.Println("ERROR:", err)
//         os.Exit(1)
//     }
//     defer file.Close()
//     scanner := bufio.NewScanner(file)
//     for scanner.Scan() {
//         line := scanner.Text()
//         if strings.HasPrefix(line, key) {
//             return strings.TrimSpace(strings.Split(line, "=")[1])
//         }
//     }
//     return ""
// }

// func fileExists(path string) bool {
//     _, err := os.Stat(path)
//     return !os.IsNotExist(err)
// }

// func parseArgs() {
//     args := os.Args[1:]
//     for i := 0; i < len(args); i++ {
//         arg := args[i]
//         if arg == "--preferred-installers" {
//             i++
//             preferredInstallers = strings.Split(args[i], " ")
//         } else if arg == "-h" || arg == "--help" {
//             doHelp()
//             os.Exit(0)
//         } else if strings.HasPrefix(arg, "--") {
//             appType := strings.TrimPrefix(arg, "--")
//             if contains(appTypes, appType) {
//                 if i+1 < len(args) && !strings.HasPrefix(args[i+1], "--") {
//                     i++
//                     appList = append(appList, strings.Split(args[i], " ")...)
//                 } else {
//                     defaultApps := getDefaultApps(appType)
//                     appList = append(appList, defaultApps...)
//                 }
//             } else {
//                 fmt.Printf("Unknown option %s\n", arg)
//                 os.Exit(1)
//             }
//         } else {
//             // Positional arguments
//         }
//     }
// }

// func doHelp() {
//     fmt.Printf("install.sh %s\n--------------------------------------------------------------------------------\n", scriptVersion)
// }

// func contains(slice []string, item string) bool {
//     for _, s := range slice {
//         if s == item {
//             return true
//         }
//     }
//     return false
// }

// func getDefaultApps(appType string) []string {
//     apps := readAppsJSON()
//     var defaultApps []string
//     for _, app := range apps {
//         if app.Type == appType && app.Default {
//             defaultApps = append(defaultApps, app.Name)
//         }
//     }
//     return defaultApps
// }

// func readAppsJSON() []App {
//     file, err := os.Open(scriptAppsList)
//     if err != nil {
//         fmt.Println("ERROR:", err)
//         os.Exit(1)
//     }
//     defer file.Close()
//     var apps []App
//     json.NewDecoder(file).Decode(&apps)
//     return apps
// }

// func sortInstallers() {
//     var sortedInstallers []string
//     for _, installer := range preferredInstallers {
//         sortedInstallers = append(sortedInstallers, installer)
//         osInstallers = remove(osInstallers, installer)
//     }
//     sortedInstallers = append(sortedInstallers, osInstallers...)
//     osInstallers = sortedInstallers
// }

// func remove(slice []string, item string) []string {
//     var newSlice []string
//     for _, s := range slice {
//         if s != item {
//             newSlice = append(newSlice, s)
//         }
//     }
//     return newSlice
// }

// func installApps() {
//     apps := readAppsJSON()
//     for _, installer := range osInstallers {
//         var packages []string
//         for _, app := range appList {
//             for _, a := range apps {
//                 if a.Name == app {
//                     packages = append(packages, a.Installers[installer]...)
//                 }
//             }
//         }
//         if len(packages) > 0 {
//             runInstaller(installer, packages)
//         }
//     }
// }

// func runInstaller(installer string, packages []string) {
//     cmd := exec.Command("sh", "-c", getInstallCommand(installer, packages))
//     cmd.Stdout = os.Stdout
//     cmd.Stderr = os.Stderr
//     err := cmd.Run()
//     if err != nil {
//         fmt.Println("ERROR:", err)
//         os.Exit(1)
//     }
// }

// func getInstallCommand(installer string, packages []string) string {
//     packageList := strings.Join(packages, " ")
//     switch installer {
//     case "apt":
//         return fmt.Sprintf("sudo apt update && sudo apt install -y %s", packageList)
//     case "brew":
//         return fmt.Sprintf("brew install %s", packageList)
//     case "snap":
//         return fmt.Sprintf("sudo snap install %s", packageList)
//     default:
//         return ""
//     }
// }

func main() {
    initVariables()
    // parseArgs()
    // determineOSType()
    // if len(preferredInstallers) == 0 {
    //     preferredInstallers = osInstallers
    // }
    // sortInstallers()
    // installApps()
}

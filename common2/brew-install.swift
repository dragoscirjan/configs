#!/usr/bin/env swift
//
// Homebrew package installer with version management (Swift version)
// Usage:
//   brew-install.swift --package PACKAGE [--version VERSION] [--force]
//
// Examples:
//   brew-install.swift --package node
//   brew-install.swift --package node --version 18
//   brew-install.swift --package cask:node --force
//

import Foundation

// Logger functions with ANSI colors
enum Logger {
  private static let reset = "\u{001B}[0m"
  private static let infoColor = "\u{001B}[32m"  // Green
  private static let debugColor = "\u{001B}[36m"  // Cyan
  private static let warnColor = "\u{001B}[33m"  // Yellow
  private static let errorColor = "\u{001B}[31m"  // Red
  private static let grayColor = "\u{001B}[90m"  // Gray</parameter>

  static func logGray(_ message: String) {
    print("\(grayColor)\(message)\(reset)")
  }

  static func logInfo(_ message: String) {
    print("\(infoColor)INFO:\(reset) \(message)")
  }

  static func logDebug(_ message: String) {
    print("\(debugColor)DEBUG:\(reset) \(message)")
  }

  static func logWarn(_ message: String) {
    print("\(warnColor)WARN:\(reset) \(message)")
  }

  static func logError(_ message: String) -> Never {
    fputs("\(errorColor)ERROR: \(message)\(reset)\n", stderr)
    exit(1)
  }
}

// Structure to hold command-line arguments
struct Config {
  var package: String = ""
  var version: String? = nil
  var forceInstall: Bool = false
}

// Represents the package information after parsing the package string: e.g., "cask:node" or "node"
struct PackageInfo {
  var repo: String?
  var packageName: String
}

// Print usage information and exit.
func usage() -> Never {
  let scriptName = (CommandLine.arguments[0] as NSString).lastPathComponent
  let helpMessage = """
    Usage: \(scriptName) --package PACKAGE [--version VERSION] [--force]

    Install Homebrew packages with version management support.

    Arguments:
      --package PACKAGE   Package name to install (required)
      --version VERSION   Specific version to install (optional)
      --force             Force reinstall even if already installed (optional)
      -h, --help         Show this help message

    Examples:
      \(scriptName) --package node
      \(scriptName) --package node --version 18
      \(scriptName) --package cask:node --force
    """
  print(helpMessage)
  exit(0)
}

// Parse command line arguments into Config
func parseArguments() -> Config {
  var config = Config()
  let args = CommandLine.arguments.dropFirst()  // Skip script name
  var index = args.startIndex

  while index < args.endIndex {
    let arg = args[index]
    switch arg {
    case "--package":
      index = args.index(after: index)
      guard index < args.endIndex else { Logger.logError("--package requires a value") }
      config.package = args[index]
    case "--version":
      index = args.index(after: index)
      guard index < args.endIndex else { Logger.logError("--version requires a value") }
      config.version = args[index]
    case "--force":
      config.forceInstall = true
    case "-h", "--help":
      usage()
    default:
      Logger.logError("Unknown argument: \(arg)")
    }
    index = args.index(after: index)
  }

  if config.package.isEmpty {
    Logger.logError("--package is required")
  }

  Logger.logDebug(
    "Parsed arguments: package=\(config.package), version=\(config.version ?? "none"), force=\(config.forceInstall)"
  )
  return config
}

// Parse package string into repository and package name components.
func parsePackageName(_ input: String) -> PackageInfo {
  if input.contains(":") {
    let parts = input.split(separator: ":", maxSplits: 1).map { String($0) }
    let repo = parts[0]
    let pkgName = parts[1]
    if pkgName.isEmpty {
      Logger.logError("Unable to determine package name from: \(input)")
    }
    return PackageInfo(repo: repo, packageName: pkgName)
  } else {
    if input.isEmpty {
      Logger.logError("Package name cannot be empty")
    }
    return PackageInfo(repo: nil, packageName: input)
  }
}

// Execute a command and return its exit status and output
// For brew commands, prints output in gray color in real-time
@discardableResult
func runCommand(_ args: [String]) -> (status: Int32, output: String) {
  let process = Process()
  process.launchPath = "/usr/bin/env"
  process.arguments = args

  let isBrew = args.first == "brew"

  if isBrew {
    // For brew commands, capture and print output in real-time with gray color
    let stdoutPipe = Pipe()
    let stderrPipe = Pipe()

    process.standardOutput = stdoutPipe
    process.standardError = stderrPipe

    var outputData = Data()

    stdoutPipe.fileHandleForReading.readabilityHandler = { handle in
      let data = handle.availableData
      if data.count > 0 {
        outputData.append(data)
        if let text = String(data: data, encoding: .utf8) {
          Logger.logGray(text.trimmingCharacters(in: .newlines))
        }
      }
    }

    stderrPipe.fileHandleForReading.readabilityHandler = { handle in
      let data = handle.availableData
      if data.count > 0 {
        outputData.append(data)
        if let text = String(data: data, encoding: .utf8) {
          Logger.logGray(text.trimmingCharacters(in: .newlines))
        }
      }
    }

    process.launch()
    process.waitUntilExit()

    // Close handlers
    stdoutPipe.fileHandleForReading.readabilityHandler = nil
    stderrPipe.fileHandleForReading.readabilityHandler = nil

    let output = String(decoding: outputData, as: UTF8.self)
    return (process.terminationStatus, output)
  } else {
    // For non-brew commands, use simple pipe
    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe
    process.launch()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(decoding: data, as: UTF8.self)
    return (process.terminationStatus, output)
  }
}

// Check if Homebrew is available
func checkBrewAvailability() {
  let result = runCommand(["command", "-v", "brew"])
  if result.status != 0 || result.output.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
    Logger.logError("Homebrew is not installed or not in PATH")
  }
  Logger.logDebug("Homebrew found in PATH")
}

// Check if a package is already installed
func isPackageInstalled(_ packageName: String, repo: String?) -> Bool {
  var args = ["brew", "list"]
  if let repo = repo, repo == "cask" {
    args.append("--cask")
  }
  args.append(packageName)
  let result = runCommand(args)
  return result.status == 0
}

// Get installed version(s) of a package using brew
// Returns an array of version strings found for the package
func getInstalledVersions(for packageName: String) -> [String] {
  let result = runCommand(["brew", "list", "--versions", packageName])
  if result.status == 0 {
    let output = result.output.trimmingCharacters(in: .whitespacesAndNewlines)
    if !output.isEmpty {
      // Output format: "packagename version1 version2 ..."
      let parts = output.split(separator: " ", maxSplits: 1)
      if parts.count > 1 {
        // Split versions by space and return as array
        return String(parts[1]).split(separator: " ").map(String.init)
      }
    }
  }
  return []
}

// Get installed versions for versioned packages (e.g., "node@18")
// This checks if a specific versioned formula is installed
func getInstalledVersionedPackage(for packageName: String, version: String) -> String? {
  let versionedPackage = "\(packageName)@\(version)"
  let result = runCommand(["brew", "list", "--versions", versionedPackage])
  if result.status == 0 {
    let output = result.output.trimmingCharacters(in: .whitespacesAndNewlines)
    if !output.isEmpty {
      return versionedPackage
    }
  }
  return nil
}

// Find all versioned packages installed (e.g., node@18, node@20)
func findVersionedPackages(for packageName: String) -> [String] {
  // List all formulae and filter for versioned packages
  let result = runCommand(["brew", "list", "--formula"])
  if result.status == 0 {
    let packages = result.output.split(separator: "\n").map(String.init)
    let pattern = "\(packageName)@"
    return packages.filter { $0.hasPrefix(pattern) }
  }
  return []
}

// Uninstall a given version of a package
func uninstallPackage(_ packageName: String, version: String) {
  let pkgWithVersion = "\(packageName)@\(version)"
  Logger.logInfo("Uninstalling \(pkgWithVersion)...")
  let result = runCommand(["brew", "uninstall", pkgWithVersion])
  if result.status != 0 {
    Logger.logWarn("Failed to uninstall \(pkgWithVersion)")
  } else {
    Logger.logInfo("Successfully uninstalled \(pkgWithVersion)")
  }
}

// Uninstall base package (without version)
func uninstallBasePackage(_ packageName: String) {
  Logger.logInfo("Uninstalling \(packageName)...")
  let result = runCommand(["brew", "uninstall", packageName])
  if result.status != 0 {
    Logger.logWarn("Failed to uninstall \(packageName)")
  } else {
    Logger.logInfo("Successfully uninstalled \(packageName)")
  }
}

// Install package using Homebrew
func installPackage(config: Config) {
  let pkgInfo = parsePackageName(config.package)

  Logger.logInfo(
    "Processing package: \(pkgInfo.packageName)\(pkgInfo.repo.map { " (\($0))" } ?? "")")

  if pkgInfo.repo == "cask", config.version != nil {
    Logger.logError(
      "Casks do not support version specification. Remove --version argument for cask packages.")
  }

  // If a specific version is requested, handle versioned package installation
  if let desiredVersion = config.version {
    let versionedPackage = "\(pkgInfo.packageName)@\(desiredVersion)"

    // Check if the desired versioned package is already installed
    if let existingVersioned = getInstalledVersionedPackage(
      for: pkgInfo.packageName, version: desiredVersion)
    {
      if !config.forceInstall {
        Logger.logInfo("\(existingVersioned) already installed; use --force to reinstall")
        return
      } else {
        Logger.logInfo("\(existingVersioned) already installed, will reinstall due to --force")
      }
    }

    // Check if base package (without version) is installed and uninstall it
    if isPackageInstalled(pkgInfo.packageName, repo: pkgInfo.repo) {
      Logger.logInfo(
        "Found base package \(pkgInfo.packageName), will be replaced with \(versionedPackage)")
      uninstallBasePackage(pkgInfo.packageName)
    }

    // Find other installed versioned packages and uninstall them
    let installedVersionedPackages = findVersionedPackages(for: pkgInfo.packageName)
    for installedPkg in installedVersionedPackages {
      if installedPkg != versionedPackage {
        // Extract version from package name
        if let atIndex = installedPkg.firstIndex(of: "@") {
          let version = String(installedPkg[installedPkg.index(after: atIndex)...])
          Logger.logInfo(
            "Found existing version \(installedPkg), will be replaced with \(versionedPackage)")
          uninstallPackage(pkgInfo.packageName, version: version)
        }
      }
    }

    // Install the versioned package
    Logger.logInfo("Installing \(versionedPackage)...")
    var installArgs = ["brew", "install"]

    if config.forceInstall {
      installArgs.append("--force")
      Logger.logDebug("Force install enabled")
    }

    installArgs.append(versionedPackage)
    Logger.logDebug("Executing command: \(installArgs.joined(separator: " "))")

    let result = runCommand(installArgs)
    if result.status == 0 {
      Logger.logInfo("Successfully installed \(versionedPackage)")
    } else {
      Logger.logError("Failed to install \(versionedPackage). Output: \(result.output)")
    }

  } else {
    // No version specified, install the default package
    let alreadyInstalled = isPackageInstalled(pkgInfo.packageName, repo: pkgInfo.repo)

    if config.forceInstall || !alreadyInstalled {
      // Find and uninstall any versioned packages before installing base package
      let installedVersionedPackages = findVersionedPackages(for: pkgInfo.packageName)
      for installedPkg in installedVersionedPackages {
        // Extract version from package name
        if let atIndex = installedPkg.firstIndex(of: "@") {
          let version = String(installedPkg[installedPkg.index(after: atIndex)...])
          Logger.logInfo(
            "Found versioned package \(installedPkg), will be replaced with \(pkgInfo.packageName)"
          )
          uninstallPackage(pkgInfo.packageName, version: version)
        }
      }

      Logger.logInfo("Installing \(pkgInfo.packageName)...")
      var installArgs = ["brew", "install"]

      if let repo = pkgInfo.repo {
        if repo == "cask" {
          installArgs.append("--cask")
          Logger.logDebug("Using cask repository")
        } else {
          installArgs.append("--\(repo)")
          Logger.logDebug("Using repository: \(repo)")
        }
      }

      if config.forceInstall {
        installArgs.append("--force")
        Logger.logDebug("Force install enabled")
      }

      installArgs.append(pkgInfo.packageName)
      Logger.logDebug("Executing command: \(installArgs.joined(separator: " "))")

      let result = runCommand(installArgs)
      if result.status == 0 {
        Logger.logInfo("Successfully installed \(pkgInfo.packageName)")
      } else {
        Logger.logError("Failed to install \(pkgInfo.packageName). Output: \(result.output)")
      }

    } else {
      Logger.logInfo("\(pkgInfo.packageName) already installed; use --force to reinstall")
    }
  }
}

func main() {
  Logger.logDebug("Starting brew-install.swift")
  checkBrewAvailability()
  let config = parseArguments()
  installPackage(config: config)
  Logger.logDebug("brew-install.swift completed successfully")
}

main()

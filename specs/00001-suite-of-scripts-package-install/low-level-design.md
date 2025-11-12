# Low Level Design: Cross-Platform Package Manager Abstraction System

## Overview

This design provides a comprehensive, cross-platform package installation abstraction layer that simplifies managing software installations across macOS, Linux, and Windows. The system addresses the core challenge of maintaining consistent package installation workflows across multiple operating systems with different package managers while handling package name variations and version management.

**Key Goals:**
- Unified API for package installation across all platforms
- Automatic package name resolution and discovery
- Support for versioned package installations with intelligent upgrade logic
- Fallback mechanisms when packages aren't found in primary sources
- Minimal maintenance burden for package name lists

**Technology Stack:**
- **macOS**: Swift (for brew wrapper)
- **Linux**: Bash 4+ (with jq dependency)
- **Windows**: PowerShell 5.1
- **Task Runner**: Task (taskfile.dev)

## Architecture

### Component Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        Taskfile.yml (Entry Point)                │
│                  Task Orchestration & Platform Routing           │
└────────────────────┬────────────────────────────────────────────┘
                     │
         ┌───────────┴───────────┐
         │                       │
         ▼                       ▼
┌────────────────────┐  ┌────────────────────┐
│  Pattern Handlers  │  │  Common2 Library   │
│  (Task Definitions)│  │  (Core Logic)      │
└────────┬───────────┘  └────────┬───────────┘
         │                       │
         └───────────┬───────────┘
                     │
     ┌───────────────┼───────────────┐
     │               │               │
     ▼               ▼               ▼
┌─────────┐   ┌──────────┐   ┌──────────┐
│ Darwin  │   │  Linux   │   │ Windows  │
│ Module  │   │  Module  │   │  Module  │
└────┬────┘   └─────┬────┘   └─────┬────┘
     │              │              │
     ▼              ▼              ▼
┌─────────┐   ┌──────────┐   ┌──────────┐
│brew-    │   │linux-install.sh│   │install.  │
│install. │   │+ package │   │ps1       │
│swift    │   │resolver  │   │+ package │
└─────────┘   └──────────┘   │resolver  │
                              └──────────┘
     │              │              │
     ▼              ▼              ▼
┌─────────┐   ┌──────────┐   ┌──────────┐
│Repology │   │Repology  │   │Package   │
│Optional │   │API Client│   │Search API│
└─────────┘   └──────────┘   └──────────┘
```

### Module Structure

```
configs/
├── common2/                      # Core abstraction library
│   ├── Taskfile.yml             # Task definitions (darwin-one, linux-one, windows-one, etc.)
│   ├── logging.sh               # Shared logging utilities (Bash)
│   ├── version-cache.sh         # Version caching system (Bash)
│   ├── brew-install.swift       # macOS package installer
│   ├── linux-install.sh               # Linux package installer (refactored)
│   ├── windows-install.ps1              # Windows package installer (refactored)
│   ├── package-resolver.sh      # NEW: Linux package name resolver
│   ├── package-resolver.ps1     # NEW: Windows package name resolver
│   ├── repology-client.sh       # NEW: Repology API client (Bash)
│   └── repology-client.ps1      # NEW: Repology API client (PowerShell)
│
├── example/
│   └── Taskfile.yml             # Pattern examples and documentation
│
└── [feature-folders]/           # shell/, terminal/, language/, etc.
    └── Taskfile.yml             # Feature-specific installations using common2 patterns
```

## Data Structures

### Package Specification Schema

Packages can be specified in multiple formats:

```yaml
# Format 1: Simple string (same name across all managers)
PACKAGE: "git"

# Format 2: Array of candidate names (try each until success)
PACKAGE: ["python", "python3", "Python.Python.3.12"]

# Format 3: Complex object (Linux partial name resolution)
PACKAGE:
  partial: "python3"
  priorities:
    - prefer: "official-repo"      # or: community-repo, lts, latest-stable, backports, testing
    - min-version: "3.9"
    - max-version: "3.13"
    - avoid-suffix: ["-dev", "-dbg", "-doc"]
    - avoid-prefix: ["old-"]
    - require-suffix: []            # e.g., ["-lts"]
  use-repology: true                # Query repology.org if local search fails
  fallback: ["python3.11", "python3.12"]  # Explicit fallback candidates
```

### Version Cache Structure (Bash/Shell)

```bash
# File: ~/.cache/dragosc-configs/package-versions.json
{
  "llvm": "20",
  "node": "lts",
  "python": "3.11"
}
```

### Repology API Response Schema

```json
{
  "project": "python",
  "packages": [
    {
      "repo": "ubuntu_22_04",
      "name": "python3.11",
      "version": "3.11.7",
      "status": "newest"
    },
    {
      "repo": "debian_stable",
      "name": "python3",
      "version": "3.11.2",
      "status": "outdated"
    }
  ]
}
```

## API Contracts

### Public Task Interfaces

These are the tasks exposed in `common2/Taskfile.yml` for use by feature Taskfiles:

#### `darwin-one`
```yaml
task: c2:darwin-one
vars:
  PACKAGE: string | array<string>  # Package name(s)
  VERSION: string (optional)       # Specific version (e.g., "18" for llvm@18)
  --force: flag (optional)         # Force reinstall
```

**Behavior:**
- Installs single package on macOS using Homebrew
- Handles versioned packages (e.g., `llvm@20`)
- Automatically removes old versions when upgrading versioned packages
- Caches installed version for upgrade tracking

#### `darwin` (Batch Install)
```yaml
task: c2:darwin
vars:
  PACKAGES: string[]               # Space-separated package names
  --force: flag (optional)
```

#### `linux-one`
```yaml
task: c2:linux-one
vars:
  PACKAGE: string | array<string> | PackageSpec  # See Package Specification Schema
  VERSION: string (optional)
  --force: flag (optional)
```

**Behavior:**
- Detects active package manager (apt, dnf, pacman, apk, flatpak, snap)
- If `PACKAGE` is string: tries name directly
- If `PACKAGE` is array: tries each candidate until one succeeds
- If `PACKAGE` is object: performs intelligent package resolution
- Falls back to Repology API if local search fails

#### `windows-one`
```yaml
task: c2:windows-one
vars:
  PACKAGE: string | array<string>  # Package name(s)
  PM: string (optional)            # Force specific PM: "winget"|"choco"|"scoop"
  --force: flag (optional)
```

**Behavior:**
- Auto-detects best available package manager (winget preferred, then choco, then scoop)
- If `PACKAGE` is array: tries each candidate until one succeeds
- If `PM` specified: only uses that package manager
- Performs package search if exact name fails

#### `install-cross` (Cross-Platform)
```yaml
task: c2:install-cross
vars:
  PACKAGE: string                  # Must be same name across all platforms
  VERSION: string (optional)
  --force: flag (optional)
```

**Behavior:**
- Routes to appropriate platform-specific installer
- Useful when package name is guaranteed consistent

### Internal Module Interfaces

#### Bash: `package-resolver.sh`

```bash
#!/usr/bin/env bash

# Resolve package name using local package manager search
#
# Arguments:
#   --package SPEC          Package specification (JSON string for complex specs)
#   --package-manager PM    Target package manager (apt, dnf, pacman, apk, flatpak, snap)
#   --repology-fallback     Enable Repology API fallback (optional)
#
# Output (JSON):
# {
#   "resolved": "python3.11",
#   "source": "local|repology|fallback",
#   "confidence": "high|medium|low",
#   "alternatives": ["python3.12", "python3.10"]
# }
#
# Exit codes:
#   0 - Success
#   1 - No candidate found
#   2 - Invalid input
```

**Key Functions:**
- `detect_package_manager()` → Returns: apt|dnf|pacman|apk|flatpak|snap|""
- `search_local_packages(partial_name, pm, priorities)` → Returns: array of matching packages
- `filter_by_priorities(packages, priorities)` → Returns: filtered + ranked array
- `query_repology(project_name)` → Returns: JSON response from Repology API
- `resolve_package(spec, pm)` → Returns: JSON resolution result

#### PowerShell: `package-resolver.ps1`

```powershell
<#
.SYNOPSIS
Resolve package name for Windows package managers

.PARAMETER Package
Package specification (string, array, or hashtable)

.PARAMETER PackageManager
Target package manager: winget, choco, or scoop

.OUTPUTS
PSCustomObject with properties:
  Resolved (string)
  Source (string): "local"|"search"|"fallback"
  Confidence (string): "high"|"medium"|"low"
  Alternatives (array)
#>

function Resolve-PackageName {
    param(
        [Parameter(Mandatory=$true)]
        $Package,

        [Parameter(Mandatory=$false)]
        [ValidateSet("winget", "choco", "scoop")]
        [string]$PackageManager
    )
}
```

**Key Functions:**
- `Get-AvailablePackageManager()` → Returns: "winget"|"choco"|"scoop"|$null
- `Search-WingetPackage($query)` → Returns: array of package IDs
- `Search-ChocoPackage($query)` → Returns: array of package names
- `Search-ScoopPackage($query)` → Returns: array of package names
- `Resolve-PackageName($spec, $pm)` → Returns: PSCustomObject

#### Repology API Client (Bash): `repology-client.sh`

```bash
# Query Repology API for package information
#
# Usage:
#   repology_query "python"
#
# Output: JSON string with package information
repology_query() {
    local project_name="${1}"
    local url="https://repology.org/api/v1/project/${project_name}"

    curl -s -H "Accept: application/json" "${url}"
}

# Find best package for specific distro
#
# Arguments:
#   project_name    Package project name
#   distro         Target distribution (e.g., "ubuntu_22_04", "debian_stable")
#   min_version    Minimum acceptable version (optional)
#
# Output: Package name or empty string
repology_find_for_distro() {
    local project_name="${1}"
    local distro="${2}"
    local min_version="${3:-}"

    # ... implementation using jq
}
```

## Algorithms & Logic

### Package Name Resolution Flow (Linux)

```
┌─────────────────────────────┐
│ Input: Package Spec         │
└──────────┬──────────────────┘
           │
           ▼
     ┌─────────────┐
     │ Is String?  │
     └──┬────────┬─┘
  YES   │        │ NO
        │        │
        ▼        ▼
   ┌────────┐  ┌──────────────┐
   │ Direct │  │ Is Array?    │
   │ Install│  └──┬─────────┬─┘
   └────────┘     │ YES     │ NO (Object)
                  │         │
                  ▼         ▼
          ┌───────────┐  ┌──────────────────┐
          │ Try Each  │  │ Parse Priorities │
          │ Candidate │  │ & Constraints    │
          └─────┬─────┘  └────────┬─────────┘
                │                 │
                │                 ▼
                │        ┌─────────────────┐
                │        │ Detect PM       │
                │        └────────┬────────┘
                │                 │
                │                 ▼
                │        ┌─────────────────┐
                │        │ Local Search    │
                │        │ (pm search)     │
                │        └────────┬────────┘
                │                 │
                │        ┌────────▼────────┐
                │        │ Filter by       │
                │        │ Priorities      │
                │        └────────┬────────┘
                │                 │
                │        ┌────────▼────────┐
                │        │ Found Matches?  │
                │        └──┬──────────┬───┘
                │      YES  │          │ NO
                │           │          │
                └───────────┤          ▼
                            │   ┌──────────────┐
                            │   │ Repology?    │
                            │   └──┬────────┬──┘
                            │ YES  │        │ NO
                            │      │        │
                            │      ▼        ▼
                            │   ┌─────┐  ┌─────────┐
                            │   │Query│  │Fallback │
                            │   │API  │  │Candidates│
                            │   └──┬──┘  └────┬────┘
                            │      │          │
                            └──────┴──────────┘
                                   │
                                   ▼
                            ┌──────────────┐
                            │ Install      │
                            │ Package      │
                            └──────────────┘
```

### Version Management Algorithm (macOS Homebrew)

```python
# Pseudocode for brew-install.swift logic

def install_package(package_name, desired_version, force):
    if desired_version:
        versioned_package = f"{package_name}@{desired_version}"

        # Check if exact versioned package already installed
        if is_installed(versioned_package) and not force:
            return "Already installed"

        # Remove base package if exists
        if is_installed(package_name):
            uninstall(package_name)

        # Find and remove other versioned packages
        for installed in find_versioned_packages(package_name):
            if installed != versioned_package:
                uninstall(installed)

        # Install desired version
        brew_install(versioned_package, force)

    else:
        # Installing base package
        if is_installed(package_name) and not force:
            return "Already installed"

        # Remove any versioned packages before installing base
        for installed in find_versioned_packages(package_name):
            uninstall(installed)

        brew_install(package_name, force)
```

### Windows Package Search Flow

```
┌──────────────────────┐
│ Package Input        │
└──────┬───────────────┘
       │
       ▼
 ┌────────────┐
 │ Is Array?  │
 └──┬─────┬───┘
    │YES  │NO
    │     │
    ▼     ▼
 ┌─────┐ ┌───────────────┐
 │Loop │ │ Try Exact ID  │
 │Each │ └───────┬───────┘
 └──┬──┘         │
    │            ▼
    │      ┌─────────────┐
    │      │ Found?      │
    │      └──┬──────┬───┘
    │    YES  │      │ NO
    │         │      │
    │         │      ▼
    │         │  ┌───────────┐
    │         │  │ Search by │
    │         │  │ Name      │
    │         │  └─────┬─────┘
    │         │        │
    │         │        ▼
    │         │  ┌───────────┐
    │         │  │ Parse     │
    │         │  │ Results   │
    │         │  └─────┬─────┘
    │         │        │
    └─────────┴────────┘
              │
              ▼
        ┌───────────┐
        │ Install   │
        └───────────┘
```

## Error Handling

### Error Classification

1. **Package Not Found** (Recoverable)
   - Trigger fallback mechanisms (try next candidate, query Repology, use fallbacks)
   - Log warning but continue with alternatives

2. **Package Manager Not Available** (Recoverable)
   - Skip to next available package manager
   - Fail only if all package managers unavailable

3. **Network Errors** (Repology API) (Recoverable)
   - Catch timeout/connection errors
   - Fall back to local resolution or explicit fallbacks
   - Log warning

4. **Version Conflicts** (Hard Error)
   - E.g., cask packages don't support versions
   - Exit with clear error message

5. **Installation Failures** (Hard Error after retries)
   - Package manager returns non-zero exit code
   - Log full output for debugging
   - Exit with error code

### Error Handling Strategy

```bash
# Linux linux-install.sh error handling pattern

install_package() {
    local spec="${1}"
    local force="${2}"

    # Try resolution
    local resolution
    if ! resolution=$(resolve_package "$spec"); then
        log_error "Failed to resolve package: $spec" 1
    fi

    local package_name
    package_name=$(echo "$resolution" | jq -r '.resolved')

    # Try installation with retries
    local max_attempts=3
    local attempt=1

    while [ $attempt -le $max_attempts ]; do
        log_info "Installation attempt $attempt/$max_attempts"

        if install_with_pm "$package_name" "$force"; then
            log_success "Successfully installed $package_name"
            return 0
        fi

        attempt=$((attempt + 1))
        [ $attempt -le $max_attempts ] && sleep 2
    done

    log_error "Failed to install $package_name after $max_attempts attempts" 1
}
```

### Exit Codes

- `0`: Success
- `1`: Package not found (after all fallbacks)
- `2`: Invalid input/arguments
- `3`: Package manager not available
- `4`: Installation failed
- `5`: Network error (Repology unreachable)
- `6`: Version conflict

## Dependencies

### macOS (Swift)
- **Homebrew**: Required, checked at runtime
- **Swift**: Pre-installed on macOS
- **Foundation**: Built-in Swift framework

### Linux (Bash)
- **Bash**: Version 4.0+ (for associative arrays)
- **jq**: JSON processor (pre-install via bootstrap script)
- **curl**: For Repology API calls
- **Package Managers**: At least one of: apt, dnf, pacman, apk, flatpak, snap

### Windows (PowerShell)
- **PowerShell**: Version 5.1+ (built-in on Windows 10+)
- **Package Managers**: At least one of: winget, choco, scoop

### Cross-Platform
- **Task**: Task runner (taskfile.dev) - installed globally
- **Git**: Required for repository access

## Testing Strategy

### Unit Tests

#### Swift Tests (macOS)
```swift
// Tests/brew-install-tests.swift
import XCTest

class BrewInstallTests: XCTestCase {
    func testParsePackageName_Simple() {
        let result = parsePackageName("node")
        XCTAssertNil(result.repo)
        XCTAssertEqual(result.packageName, "node")
    }

    func testParsePackageName_WithRepo() {
        let result = parsePackageName("cask:firefox")
        XCTAssertEqual(result.repo, "cask")
        XCTAssertEqual(result.packageName, "firefox")
    }

    func testFindVersionedPackages() {
        // Mock brew list output
        let packages = findVersionedPackages(for: "llvm")
        XCTAssertTrue(packages.contains("llvm@18"))
        XCTAssertTrue(packages.contains("llvm@20"))
    }
}
```

#### Bash Tests (Linux)
```bash
# tests/test-package-resolver.sh
#!/usr/bin/env bash

source ../common2/package-resolver.sh

test_detect_package_manager() {
    local pm
    pm=$(detect_package_manager)

    [[ -n "$pm" ]] || {
        echo "FAIL: detect_package_manager returned empty"
        return 1
    }

    echo "PASS: Detected package manager: $pm"
}

test_search_local_packages() {
    local results
    results=$(search_local_packages "python3" "apt" "")

    [[ -n "$results" ]] || {
        echo "FAIL: search_local_packages returned no results"
        return 1
    }

    echo "PASS: Found packages: $results"
}

# Run tests
test_detect_package_manager
test_search_local_packages
```

#### PowerShell Tests (Windows)
```powershell
# Tests/PackageResolver.Tests.ps1
Describe "PackageResolver" {
    It "Detects available package manager" {
        $pm = Get-AvailablePackageManager
        $pm | Should -BeIn @("winget", "choco", "scoop")
    }

    It "Resolves simple package name" {
        $result = Resolve-PackageName -Package "git" -PackageManager "winget"
        $result.Resolved | Should -Not -BeNullOrEmpty
        $result.Confidence | Should -Be "high"
    }

    It "Handles array of candidates" {
        $result = Resolve-PackageName -Package @("python", "python3") -PackageManager "winget"
        $result.Resolved | Should -Not -BeNullOrEmpty
    }
}
```

### Integration Tests

```yaml
# tests/integration/test-installations.yml
version: "3"

tasks:
  test-macos-simple:
    cmds:
      - task: c2:darwin-one
        vars:
          PACKAGE: wget
      - command -v wget || exit 1
    platforms: [darwin]

  test-macos-versioned:
    cmds:
      - task: c2:darwin-one
        vars:
          PACKAGE: llvm
          VERSION: "18"
      - test -d /opt/homebrew/opt/llvm@18 || exit 1
    platforms: [darwin]

  test-linux-resolution:
    cmds:
      - task: c2:linux-one
        vars:
          PACKAGE:
            partial: "python3"
            priorities:
              - prefer: "official-repo"
              - min-version: "3.9"
      - command -v python3 || exit 1
    platforms: [linux]

  test-windows-candidates:
    cmds:
      - task: c2:windows-one
        vars:
          PACKAGE: ["git", "Git.Git"]
      - where.exe git || exit 1
    platforms: [windows]
```

### Test Execution

```bash
# Run all tests
task test:all

# Run platform-specific tests
task test:darwin
task test:linux
task test:windows

# Run unit tests only
task test:unit

# Run integration tests only
task test:integration
```

## Performance Considerations

### Caching Strategy

1. **Version Cache** (Already Implemented)
   - Cache installed package versions in `~/.cache/dragosc-configs/package-versions.json`
   - Prevents unnecessary uninstall/reinstall cycles
   - Invalidate on explicit version changes

2. **Package Search Cache** (NEW)
   - Cache package manager search results for 24 hours
   - Key: `<pm>:<search_term>` → `<results_json>`
   - Location: `~/.cache/dragosc-configs/package-search-cache.json`

3. **Repology Cache** (NEW)
   - Cache Repology API responses for 7 days
   - Key: `<project_name>` → `<api_response>`
   - Location: `~/.cache/dragosc-configs/repology-cache.json`

### Optimization Strategies

1. **Parallel Installations**
   - Use Task's parallel execution for independent packages
   - Example: `task darwin PACKAGES="git curl wget" --parallel`

2. **Early Exit**
   - Check if package already installed before attempting resolution
   - Skip resolution entirely for force reinstalls with explicit package names

3. **Lazy Loading**
   - Don't load Repology client unless needed
   - Don't detect all package managers unless required

4. **Efficient Search**
   - Limit package manager search results to top 10 matches
   - Use regex filtering before calling external search commands

### Expected Performance

- **Simple install (cached, already installed)**: < 1 second
- **Simple install (uncached, needs installation)**: 10-60 seconds (depends on PM)
- **Complex resolution (Repology query)**: 2-5 seconds
- **Batch install (10 packages, parallel)**: 30-120 seconds

## Security Considerations

### Package Verification

1. **Homebrew** (macOS)
   - Inherits Homebrew's built-in checksumming
   - All packages from official taps are verified

2. **Linux Package Managers**
   - apt/dnf: Use signature verification (built-in)
   - snap/flatpak: Sandboxed by default
   - Manual installs: Verify checksums when available

3. **Windows Package Managers**
   - winget: Uses package manifests with hash verification
   - choco: Uses package checksums
   - scoop: Hash verification for all packages

### Input Validation

```bash
# Validate package specification
validate_package_spec() {
    local spec="${1}"

    # Prevent command injection
    if [[ "$spec" =~ [';''\$''`''|''&'] ]]; then
        log_error "Invalid characters in package specification" 2
    fi

    # Validate JSON structure for complex specs
    if [[ "$spec" == '{'* ]]; then
        echo "$spec" | jq empty || log_error "Invalid JSON in package spec" 2
    fi
}
```

### API Security (Repology)

- Use HTTPS only for API calls
- Timeout after 10 seconds to prevent hanging
- Validate JSON response structure before parsing
- Rate limit: Max 1 request per second per project

### Script Execution Safety

- All shell scripts use `set -euo pipefail`
- PowerShell scripts use `-ErrorAction Stop`
- No `eval` or dynamic code execution
- All external commands use explicit paths or validated inputs

## Implementation Notes

### Phase 1: Core Infrastructure (Week 1-2)
- Refactor `linux-install.sh` and `windows-install.ps1` to use modular resolution
- Implement `package-resolver.sh` and `package-resolver.ps1`
- Implement Repology API clients
- Add caching layer

### Phase 2: Pattern Support (Week 3)
- Update `common2/Taskfile.yml` with new `linux-one` and `windows-one` implementations
- Test all patterns from `example/Taskfile.yml`
- Migrate `shell/Taskfile.yml` to use new patterns

### Phase 3: Migration (Week 4-5)
- Migrate `terminal/Taskfile.yml`
- Migrate `language/Taskfile.yml`
- Update remaining Taskfiles

### Phase 4: Documentation & Testing (Week 6)
- Write comprehensive test suite
- Update README files
- Create migration guide for existing Taskfiles

### Technical Debt to Address
- Remove old `common/` folder after full migration to `common2/`
- Consolidate logging utilities (currently duplicated across Bash/PowerShell)
- Standardize error codes across all scripts
- Add telemetry (optional) to track resolution success rates

### Known Limitations
- Repology API doesn't cover all packages (especially newer ones)
- Windows package manager search can be slow (especially winget)
- Some package managers don't support version constraints (e.g., snap)
- Cross-distro package name mapping is heuristic-based (not 100% accurate)

### Future Enhancements
- Support for custom package registries/mirrors
- Offline mode with cached package lists
- Package recommendation system based on system architecture
- Auto-generate package name mappings from community database
- Support for language-specific package managers (npm, pip, cargo, etc.)

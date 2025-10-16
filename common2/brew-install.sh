#!/usr/bin/env bash
#
# Homebrew package installer with version management
#
# Usage:
#   brew-install.sh --package PACKAGE [--version VERSION] [--force]
#
# Arguments:
#   --package PACKAGE   Package name to install (required)
#   --version VERSION   Specific version to install (optional)
#   --force            Force reinstall even if already installed (optional)
#
# Examples:
#   brew-install.sh --package node
#   brew-install.sh --package node --version 18
#   brew-install.sh --package cask:node --force

set -euo pipefail

readonly SCRIPT_NAME="$(basename "${0}")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CACHE_DIR="${HOME}/.cache/dragosc-configs"

# Source logging utilities
source "${SCRIPT_DIR}/logging.sh"
# Source version cache utilities
source "${SCRIPT_DIR}/version-cache.sh"

# Global variables
PACKAGE=""
VERSION=""
FORCE_INSTALL=false
REPO=""
PACKAGE_NAME=""

#######################################
# Print usage information
# Globals:
#   SCRIPT_NAME
# Arguments:
#   None
#######################################
usage() {
  cat << EOF
Usage: ${SCRIPT_NAME} --package PACKAGE [--version VERSION] [--force]

Install Homebrew packages with version management support.

Arguments:
  --package PACKAGE   Package name to install (required)
  --version VERSION   Specific version to install (optional)
  --force            Force reinstall even if already installed (optional)
  -h, --help         Show this help message

Examples:
  ${SCRIPT_NAME} --package node
  ${SCRIPT_NAME} --package node --version 18
  ${SCRIPT_NAME} --package cask:node --force
EOF
}

#######################################
# Parse command line arguments
# Globals:
#   PACKAGE, VERSION, FORCE_INSTALL
# Arguments:
#   Command line arguments
#######################################
parse_args() {
  log_debug "Parsing command line arguments: $*"

  while [[ ${#} -gt 0 ]]; do
    case "${1}" in
      --package)
        [[ -n "${2:-}" ]] || log_error "--package requires a value"
        PACKAGE="${2}"
        log_debug "Package set to: ${PACKAGE}"
        shift 2
        ;;
      --version)
        [[ -n "${2:-}" ]] || log_error "--version requires a value"
        VERSION="${2}"
        log_debug "Version set to: ${VERSION}"
        shift 2
        ;;
      --force)
        FORCE_INSTALL=true
        log_debug "Force install enabled"
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        log_error "Unknown argument: ${1}"
        ;;
    esac
  done

  # Validate required arguments
  [[ -n "${PACKAGE}" ]] || log_error "--package is required"
}

#######################################
# Parse package name into repository and package components
# Arguments:
#   Package string (e.g., "cask:node" or "node")
# Returns:
#   Sets REPO and PACKAGE_NAME variables
#######################################
parse_package_name() {
  local package_input="${1:-}"

  # Validate input parameter
  [[ -n "${package_input}" ]] || log_error "parse_package_name requires a package name parameter"

  # Split package on ':' to separate repo from package name
  if [[ "${package_input}" == *:* ]]; then
    REPO="${package_input%%:*}"
    PACKAGE_NAME="${package_input##*:}"
  else
    REPO=""
    PACKAGE_NAME="${package_input}"
  fi

  # Validate we have a package name
  [[ -n "${PACKAGE_NAME}" ]] || log_error "Unable to determine package name from: ${package_input}"
}

#######################################
# Check if a package is already installed
# Arguments:
#   Package name
#   Repository type (optional: "cask" or empty)
# Returns:
#   0 if installed, 1 if not installed
#######################################
is_package_installed() {
  local package_name="${1:-}"
  local repo="${2:-}"

  # Validate input parameter
  [[ -n "${package_name}" ]] || log_error "is_package_installed requires a package name parameter"

  if [[ "${repo}" == "cask" ]]; then
    brew list --cask "${package_name}" &>/dev/null
  else
    brew list "${package_name}" &>/dev/null
  fi
}



#######################################
# Install package using Homebrew
# Globals:
#   PACKAGE, VERSION, FORCE_INSTALL
#######################################
install_package() {
  local old_version

  # Parse package name
  parse_package_name "${PACKAGE}"

  log_info "Processing package: ${PACKAGE_NAME}${REPO:+ (${REPO})}"

  # Validate package type and version compatibility
  # Note: For tap packages, use format "tap/package_name" (e.g., "homebrew/cask/vscode")
  # The brew command will automatically handle taps when package contains '/'
  if [[ "${REPO}" == "cask" && -n "${VERSION}" ]]; then
    log_error "Casks do not support version specification. Remove --version argument for cask packages."
  fi

  # Get cached version for upgrade logic
  old_version="$(get_cached_version "${PACKAGE_NAME}")"
  log_debug "Cached version for ${PACKAGE_NAME}: ${old_version:-none}"

  # Handle version-specific installations - ONLY uninstall if version is specified AND cached version exists AND they differ
  if [[ -n "${VERSION}" && -n "${old_version}" && "${old_version}" != "${VERSION}" ]]; then
    log_info "Upgrading from version ${old_version} to ${VERSION}"
    if ! brew uninstall "${PACKAGE_NAME}@${old_version}"; then
      log_warn "Failed to uninstall old version ${old_version}"
    fi
  fi

  # Check if already installed and handle force flag
  if [[ "${FORCE_INSTALL}" == "true" ]] || ! is_package_installed "${PACKAGE_NAME}" "${REPO}"; then
    log_info "Installing ${PACKAGE_NAME}..."

    # Build install command properly based on package type
    local install_cmd=("brew" "install")

    # Add repository-specific flags
    if [[ "${REPO}" == "cask" ]]; then
      install_cmd+=("--cask")
      log_debug "Using cask repository"
    elif [[ -n "${REPO}" && "${REPO}" != "cask" ]]; then
      install_cmd+=("--${REPO}")
      log_debug "Using repository: ${REPO}"
    fi

    # Add force flag if specified
    if [[ "${FORCE_INSTALL}" == "true" ]]; then
      install_cmd+=("--force")
      log_debug "Force install enabled"
    fi

    # Add package name with version if specified
    if [[ -n "${VERSION}" ]]; then
      install_cmd+=("${PACKAGE_NAME}@${VERSION}")
      log_debug "Installing specific version: ${VERSION}"
    else
      install_cmd+=("${PACKAGE_NAME}")
    fi

    log_debug "Executing command: ${install_cmd[*]}"

    # Execute install command
    if "${install_cmd[@]}"; then
      log_success "Successfully installed ${PACKAGE_NAME}${VERSION:+ version ${VERSION}}"
    else
      log_error "Failed to install ${PACKAGE_NAME}"
    fi
  else
    log_info "${PACKAGE} already installed; use --force to reinstall"
  fi
}

#######################################
# Main function
#######################################
main() {
  log_debug "Starting ${SCRIPT_NAME}"

  # Check if brew is available
  if ! command -v brew >/dev/null 2>&1; then
    log_error "Homebrew is not installed or not in PATH"
  fi

  log_debug "Homebrew found in PATH"

  # Parse command line arguments
  parse_args "$@"

  # Install the package
  install_package

  log_debug "${SCRIPT_NAME} completed successfully"
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi

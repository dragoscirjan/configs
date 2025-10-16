#!/usr/bin/env bash
#
# Version cache management utilities
#
# This script provides functions to manage version caching for installed packages.
# It can be sourced by other scripts to provide consistent version tracking.
#
# Usage:
#   source version-cache.sh
#   cache_version "package-name" "1.2.3"
#   get_cached_version "package-name"
#   update_cached_version "package-name" "1.2.4"

# Default cache directory - can be overridden by setting CACHE_DIR
readonly DEFAULT_CACHE_DIR="${HOME}/.cache/dragosc-configs"
readonly VERSION_CACHE_DIR="${CACHE_DIR:-$DEFAULT_CACHE_DIR}"

#######################################
# Get the cached version for a package
# Arguments:
#   Package name
# Returns:
#   Version string or empty if not found
# Outputs:
#   Version to stdout
#######################################
get_cached_version() {
  local package_name="${1}"
  local version_file="${VERSION_CACHE_DIR}/${package_name}-version"

  if [[ -f "${version_file}" ]]; then
    cat "${version_file}" 2>/dev/null || echo ""
  else
    echo ""
  fi
}

#######################################
# Store version information for a package
# Arguments:
#   Package name
#   Version (optional - if empty, removes version file)
# Returns:
#   0 on success, 1 on failure
#######################################
cache_version() {
  local package_name="${1}"
  local version="${2:-}"
  local version_file="${VERSION_CACHE_DIR}/${package_name}-version"

  # Create cache directory if it doesn't exist
  if ! mkdir -p "${VERSION_CACHE_DIR}"; then
    echo "Error: Could not create cache directory ${VERSION_CACHE_DIR}" >&2
    return 1
  fi

  if [[ -n "${version}" ]]; then
    if echo "${version}" > "${version_file}"; then
      return 0
    else
      echo "Error: Could not write version to ${version_file}" >&2
      return 1
    fi
  else
    rm -f "${version_file}"
    return 0
  fi
}

#######################################
# Update cached version if it has changed
# Arguments:
#   Package name
#   New version
# Returns:
#   0 if updated or already current, 1 on error
# Outputs:
#   Status message to stdout
#######################################
update_cached_version() {
  local package_name="${1}"
  local new_version="${2:-}"
  local cached_version

  cached_version="$(get_cached_version "${package_name}")"

  if [[ "${cached_version}" != "${new_version}" ]]; then
    if cache_version "${package_name}" "${new_version}"; then
      if [[ -n "${new_version}" ]]; then
        echo "Updated cached version for ${package_name} to ${new_version}"
      else
        echo "Removed cached version for ${package_name}"
      fi
    else
      echo "Failed to update cached version for ${package_name}" >&2
      return 1
    fi
  else
    if [[ -n "${new_version}" ]]; then
      echo "Cached version for ${package_name} is already up to date (${new_version})"
    else
      echo "No cached version for ${package_name}"
    fi
  fi

  return 0
}

#######################################
# Check if a version has changed since last cache
# Arguments:
#   Package name
#   Current version
# Returns:
#   0 if version has changed, 1 if same or error
#######################################
has_version_changed() {
  local package_name="${1}"
  local current_version="${2:-}"
  local cached_version

  cached_version="$(get_cached_version "${package_name}")"

  [[ "${cached_version}" != "${current_version}" ]]
}

#######################################
# List all cached versions
# Returns:
#   0 on success
# Outputs:
#   List of package:version pairs to stdout
#######################################
list_cached_versions() {
  local version_file
  local package_name
  local version

  if [[ ! -d "${VERSION_CACHE_DIR}" ]]; then
    echo "No version cache directory found at ${VERSION_CACHE_DIR}" >&2
    return 1
  fi

  for version_file in "${VERSION_CACHE_DIR}"/*-version; do
    if [[ -f "${version_file}" ]]; then
      package_name="$(basename "${version_file}" -version)"
      version="$(cat "${version_file}" 2>/dev/null)"
      if [[ -n "${version}" ]]; then
        echo "${package_name}:${version}"
      fi
    fi
  done
}

#######################################
# Clear all cached versions
# Returns:
#   0 on success, 1 on failure
#######################################
clear_version_cache() {
  if [[ -d "${VERSION_CACHE_DIR}" ]]; then
    if rm -f "${VERSION_CACHE_DIR}"/*-version 2>/dev/null; then
      echo "Cleared all cached versions"
      return 0
    else
      echo "Failed to clear version cache" >&2
      return 1
    fi
  else
    echo "No version cache to clear"
    return 0
  fi
}

#!/usr/bin/env bash
#
# Logging utilities for shell scripts
#
# Provides utility functions for logging and displaying debug, info, warning,
# and error messages with colored output.
# The functions use ANSI escape codes to color the text for better visibility.
# The Greek letter lambda (λ) is used as a prefix to distinguish log messages.
#
# Usage:
#   source logging.sh
#   log_info "This is an info message"
#   log_warn "This is a warning"
#   log_error "This is an error" 1
#   DEBUG=1 log_debug "This debug message will show"
#
# Follows Google Bash Style Guide: https://google.github.io/styleguide/shellguide.html

# Since this file is sourced, don't use set -euo pipefail as it affects the parent script

# Color constants - using consistent ANSI escape codes
readonly LOG_COLOR_BLUE="\033[0;34m"
readonly LOG_COLOR_RED="\033[0;31m"
readonly LOG_COLOR_GREEN="\033[0;32m"
readonly LOG_COLOR_YELLOW="\033[0;33m"
readonly LOG_COLOR_CYAN="\033[0;36m"
readonly LOG_COLOR_RESET="\033[0m"

# Lambda symbol used as prefix for all log messages
readonly LOG_PREFIX="λ"

#######################################
# Internal logging function that prints a message with specified color.
# Should not be called directly - use the specific log level functions instead.
# Globals:
#   None
# Arguments:
#   $1 - Color code for the message
#   $2 - Log level (DEBUG, INFO, WARN, ERROR)
#   $3 - The message to display. If empty, reads from stdin.
# Outputs:
#   Colored log message to stdout or stderr
#######################################
_log_with_color() {
    local color="${1}"
    local level="${2}"
    local message="${3:-}"

    # Get current timestamp
    local timestamp
    timestamp="$(date '+%Y-%m-%d %H:%M:%S')"

    if [[ -z "${message}" ]]; then
        while IFS= read -r line; do
            printf "${color}${LOG_PREFIX} [%s] %s: %s${LOG_COLOR_RESET}\n" "${timestamp}" "${level}" "${line}"
        done
    else
        printf "${color}${LOG_PREFIX} [%s] %s: %s${LOG_COLOR_RESET}\n" "${timestamp}" "${level}" "${message}"
    fi
}

#######################################
# Prints a debug message in blue if DEBUG environment variable is set.
# Globals:
#   DEBUG - If set, enables debug output
# Arguments:
#   $1 - The debug message to display
# Outputs:
#   Blue debug message to stderr if debugging is enabled
#######################################
log_debug() {
    [[ -n "${1:-}" ]] || return 1
    if [[ -n "${DEBUG:-}" ]]; then
        _log_with_color "${LOG_COLOR_BLUE}" "DEBUG" "${1}" >&2
    fi
}

#######################################
# Prints an informational message in cyan.
# Globals:
#   None
# Arguments:
#   $1 - The info message to display
# Outputs:
#   Cyan info message to stdout
#######################################
log_info() {
    _log_with_color "${LOG_COLOR_CYAN}" "INFO" "${1}"
}

#######################################
# Prints a success message in green.
# Globals:
#   None
# Arguments:
#   $1 - The success message to display
# Outputs:
#   Green success message to stdout
#######################################
log_success() {
    _log_with_color "${LOG_COLOR_GREEN}" "SUCCESS" "${1}"
}

# Alias for backwards compatibility
log() {
    log_info "$@"
}

#######################################
# Prints a warning message in yellow.
# Globals:
#   None
# Arguments:
#   $1 - The warning message to display
# Outputs:
#   Yellow warning message to stderr
#######################################
log_warn() {
    [[ -n "${1:-}" ]] || return 1
    _log_with_color "${LOG_COLOR_YELLOW}" "WARN" "${1}" >&2
}

#######################################
# Prints an error message in red and exits the script.
# Globals:
#   None
# Arguments:
#   $1 - The error message to display
#   $2 - Exit code (optional, defaults to 1)
# Outputs:
#   Red error message to stderr
# Exits:
#   With specified exit code (default 1)
#######################################
log_error() {
    local message="${1:-Unknown error}"
    local exit_code="${2:-1}"

    _log_with_color "${LOG_COLOR_RED}" "ERROR" "${message}" >&2
    exit "${exit_code}"
}

# Alias for backwards compatibility
error_exit() {
    log_error "$@"
}

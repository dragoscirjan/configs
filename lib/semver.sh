#!/usr/bin/env bash

#
# Performs a simple semver comparison of the two arguments.
#
# Original: https://github.com/mritd/shell_scripts/blob/master/version.sh
# Snippet: https://jonlabelle.com/snippets/view/shell/compare-semver-versions-in-bash
# Gist: https://gist.github.com/jonlabelle/6691d740f404b9736116c22195a8d706
#

readonly SCRIPTNAME="$(basename "${BASH_SOURCE[0]}")"

function usage() {
    echo "Usage: $SCRIPTNAME <semver1> <semver2>"
    echo
    echo "Options:"
    echo "  -h, --help    Show this help message and exit."
    echo
    echo "Examples:"
    echo "$SCRIPTNAME 1.12.1 1.0.0"
    echo
}

function semver_or_die() {
    local version
    version="$1"
    if [[ ! ${version} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        printf >&2 'Error : %s is not a valid semver.\n' $version
        exit 1
    fi
}

function version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }
function version_le() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" == "$1"; }
function version_lt() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" != "$1"; }
function version_ge() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"; }

if [[ "$1" = "-h" || "$1" = "--help" ]]; then
    usage
    exit 0
fi

if [[ $# -eq 0 || -z $1 || -z $2 ]]; then
    printf >&2 'Error : missing required arguments.\n\n'
    usage
    exit 1
fi

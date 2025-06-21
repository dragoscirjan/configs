#!/usr/bin/env bash

# Usage:
#   ./instal.sh [-f|--force] [-p|--package "manager:pkg;manager2:pkg2;pkg3"]
# If manager is omitted, tries all in default order.

set -ex

PACKAGE=""
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
  -p | --package)
    PACKAGE="$2"
    shift 2
    ;;
  -f | --force)
    FORCE=1
    shift
    ;;
  *)
    shift
    ;;
  esac
done

declare -A install_cmds
declare -A force_install_cmds

install_cmds["apk"]="sudo apk add"
force_install_cmds["apk"]="sudo apk add --force-overwrite"

install_cmds["apt"]="sudo apt install -y"
force_install_cmds["apt"]="sudo apt install -y --reinstall"

install_cmds["apt-get"]="sudo apt-get install -y"
force_install_cmds["apt-get"]="sudo apt-get install -y --reinstall"

install_cmds["rpm"]="sudo rpm -i"
force_install_cmds["rpm"]="sudo rpm -i --replacepkgs"

install_cmds["yum"]="sudo yum install -y"
force_install_cmds["yum"]="sudo yum install -y --replacepkgs"

install_cmds["dnf"]="sudo dnf install -y"
force_install_cmds["dnf"]="sudo dnf install -y --allowerasing"

install_cmds["snap"]="sudo snap install"
force_install_cmds["snap"]="sudo snap install --dangerous --devmode"

install_cmds["brew"]="brew install"
force_install_cmds["brew"]="brew reinstall"

parse_packages() {
  local input="$1"
  local -n out_arr=$2
  IFS=';' read -ra entries <<<"$input"
  for entry in "${entries[@]}"; do
    entry="${entry// /}"
    if [[ "$entry" == *:* ]]; then
      out_arr+=("$entry")
    elif [[ -n "$entry" ]]; then
      out_arr+=(":$entry")
    fi
  done
}

declare -a packages
if [[ -n "$PACKAGE" ]]; then
  parse_packages "$PACKAGE" packages
fi

if [[ ${#packages[@]} -eq 0 ]]; then
  packages=(
    "apk:$PACKAGE"
    "apt:$PACKAGE"
    "apt-get:$PACKAGE"
    "rpm:$PACKAGE"
    "yum:$PACKAGE"
    "dnf:$PACKAGE"
    "snap:$PACKAGE"
    "brew:$PACKAGE"
  )
fi

install_success=0

for pkginfo in "${packages[@]}"; do
  manager="${pkginfo%%:*}"
  pkg="${pkginfo#*:}"

  [[ -z "$pkg" ]] && continue

  if [[ -z "$manager" ]]; then
    for m in apk apt apt-get rpm yum dnf snap brew; do
      if command -v "$m" >/dev/null 2>&1; then
        manager="$m"
        break
      fi
    done
    [[ -z "$manager" ]] && continue
  fi

  if ! command -v "$manager" >/dev/null 2>&1; then
    echo "Package manager $manager not found. Skipping."
    continue
  fi

  if [[ $FORCE -eq 1 ]]; then
    cmd="${force_install_cmds[$manager]}"
    echo "Attempting to force install $pkg using $manager..."
  else
    cmd="${install_cmds[$manager]}"
    echo "Attempting to install $pkg using $manager..."
  fi

  set +e
  $cmd "$pkg"
  status=$?
  set -e

  if [[ $status -eq 0 ]]; then
    echo "Successfully installed $pkg using $manager."
    install_success=1
    break
  else
    echo "Failed to install $pkg using $manager (exit code $status)."
  fi
done

if [[ $install_success -eq 0 ]]; then
  echo "Failed to install $PACKAGE using any available package manager."
  exit 1
fi

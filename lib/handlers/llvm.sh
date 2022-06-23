#!/usr/bin/env bash

[ -n "$GLVM_DEBUG" ] && {
    set -x
}

# . "$GLVM_ROOT/lib/functions" || exit 1

function handler_llvm() {
  command=$1
  # if [[ $command == "implode" ]]; then
  #     llvm_implode
  #     exit 0
  # fi

  # "$GLVM_ROOT/scripts/llvm-check"
  # if [[ "$?" != "0" ]]; then
  #     display_fatal "Missing requirements."
  # fi

  if [[ $command == "version" ]]; then
    display_message "LLVM Clang Version Manager v$llvm_VERSION installed at $llvm_ROOT"
  else
    if [ -f "$GLVM_ROOT/lib/handlers/llvm/$command.sh" ]; then
      source  "$GLVM_ROOT/lib/handlers/llvm/$command.sh"
      $command ${@:2}
    elif [[ -z $command || $command = help ]]; then
      echo "Usage: llvm [command]

Description:
  LLVM is the Clang Version Manager

Commands:
  version    - print the llvm version number
  get        - gets the latest code (for debugging)
  use        - select a go version to use (--default to set permanently)
  diff       - view changes to Go root
  help       - display this usage text
  implode    - completely remove llvm
  install    - install go versions
  uninstall  - uninstall go versions
  cross      - install go cross compilers
  linkthis   - link this directory into GOPATH
  list       - list installed go versions
  listall    - list available versions
  alias      - manage go version aliases
  pkgset     - manage go packages sets
  pkgenv     - edit the environment for a package set
"
    else
      display_fatal "Unrecognized command line argument: '$command'"
    fi
  fi
}

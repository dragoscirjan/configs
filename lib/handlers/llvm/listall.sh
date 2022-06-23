#!/usr/bin/env bash

[ -n "$GLVM_DEBUG" ] && {
    set -x
}

source $GLVM_ROOT/lib/releases.sh || exit 1

function listall() {
  github_releases /llvm/llvm-project/releases
}

#!/usr/bin/env bash

[ -n "$GLVM_DEBUG" ] && {
    set -x
}

# source $GLVM_ROOT/lib/semver.sh

function handler_golang() {
    # install gvm

    which gvm > /dev/null \
    || ( bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) && source "$HOME/.gvm/scripts/gvm" )

    source "$HOME/.gvm/scripts/gvm"


    # install dependencies

    # which apt > /dev/null \
    # && sudo apt-get install curl git mercurial make binutils bison gcc build-essential

    # which brew > /dev/null \
    # && xcode-select --install \
    # && brew update \
    # && brew install mercurial

    # which yum > /dev/null \
    # && sudo yum install curl git make bison gcc glibc-devel

    # install go 1.4 if required version is bigger

    which go > /dev/null || \
    if [[ $1 == "install" ]]; then

        version=$2
        echo ${version/go/}

        if version_gt ${version/go/} 1.4; then
            gvm install go1.4 -B
            gvm use go1.4
            export GOROOT_BOOTSTRAP=$GOROOT
        fi

    fi

    # run gvm default

    gvm $@
}

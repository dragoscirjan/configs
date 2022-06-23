#!/usr/bin/env bash

GITHUB_LIST_MAX_RELEASE_PAGES=${GITHUB_LIST_MAX_RELEASE_PAGES:-5}

function github_releases() {
    local url="https://github.com/$1"
    local step=${2:-0}
    local max_step=$((GITHUB_LIST_MAX_RELEASE_PAGES-1))

    # echo $url $step

    curl -sSL $url | grep "/tag/" | awk -F '"' '{ print $6 }' | awk -F '/' '{ print $NF }';

    if [[ $step -gt $max_step ]]; then
        return
    fi

    curl -sSL $url | grep "next_page" > /dev/null \
    && github_releases $(curl -sSL https://github.com/llvm/llvm-project/releases | grep next_page | tail -n 1 | awk -F '"' '{ print $(NF-1) }') $(($step + 1))
}

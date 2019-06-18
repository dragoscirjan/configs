#! /bin/bash
set -xe

binary=$(curl -sSL https://github.com/stedolan/jq/releases | grep jq-win64.exe | head -n 1 | awk -F'"' '{print $2}')

mkdir -p ~/bin

curl -sSL https://github.com$binary > jq.exe

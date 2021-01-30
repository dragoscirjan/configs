#!/bin/bash
set -ex

# ubuntu version
version=20.04

# download destination
destination=/tmp

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--ubuntu-version)
    version="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--destination)
    destination="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

curl -sSL "http://old-releases.ubuntu.com/releases/$version/ubuntu-$version-desktop-amd64.iso" --output "$destination/ubuntu.iso"

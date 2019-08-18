#! /bin/bash

https://snapcraft.io/docs/installing-snapd

( sudo apt-get update && sudo apt-get install -y snapd ) \
	|| ( sudo apt update && sudo apt install -y snapd ) \
	|| sudo dnf install snapd \
	|| ( sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_15.0 snappy \
			&& sudo zypper --gpg-auto-import-keys refresh && sudo zypper dup --from snappy && sudo zypper install snapd ) \
	|| ( sudo yum install epel-release && sudo yum install snapd )
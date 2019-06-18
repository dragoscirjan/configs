#! /bin/bash
set -e

curl -sL https://get.docker.com | bash

curl -L "https://github.com/docker/compose/releases/download/$(curl -sLS https://github.com/docker/compose/releases | grep releases | grep tag | awk -F'>' '{print $2}' | awk -F'<' '{print $1}' | grep 1 | head -n1)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

curl -L https://github.com/docker/machine/releases/download/$(curl -sLS https://github.com/docker/machine/releases | grep releases | grep tag | awk -F'>' '{print $2}' | awk -F'<' '{print $1}' | grep 1 | head -n1)/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine
chmod +x /usr/local/bin/docker-machine
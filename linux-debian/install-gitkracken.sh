#! /bin/bash
set -e

which apt-get > /dev/null && {
  curl -sL https://release.gitkraken.com/linux/gitkraken-amd64.deb > /tmp/kraken.deb
  dpkg -i /tmp/kraken.deb || apt-get install -yf
  rm /tmp/kraken.deb
}
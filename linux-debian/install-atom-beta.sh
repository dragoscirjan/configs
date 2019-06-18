#! /bin/bash
set -e

which apt-get > /dev/null && {
  curl -sL https://atom.io/download/deb?channel=beta > /tmp/atom.deb
  dpkg -i /tmp/atom.deb || apt-get install -yf
  rm /tmp/atom.deb
}
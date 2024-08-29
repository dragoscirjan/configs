#! /bin/bash

# Fish Shell https://fishshell.com/
#
uname -a | grep Darwin 2>/dev/null \
  && brew install fish

if [[ -f /etc/os-release ]]; then
  . /etc/os-release

  # https://launchpad.net/~fish-shell/+archive/ubuntu/release-3
  if [[ "$ID" == "ubuntu" ]]; then
    sudo apt-add-repository ppa:fish-shell/release-3 \
      && sudo apt update \
      && sudo apt install fish
  fi

  # Fedora 40 https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A3&package=fish
  if [[ "$ID" == "fedora" ]]; then
    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/shells:fish:release:3/Fedora_40/shells:fish:release:3.repo \
      && dnf install fish
  fi
fi

# FuzzyFinder https://github.com/junegunn/fzf?tab=readme-ov-file#installation
#
uname -a | grep Darwin 2>/dev/null \
  && brew install fzf
which apk 2>/dev/null && sudo apk add fzf
which apt 2>/dev/null && sudo apt install fzf -y
which dnf 2>/dev/null && sudo dnf install fzf -y

# Z (Directory Jumper) for Fish shell https://github.com/jethrokuan/z
#
which fisher 2>/dev/null && fisher install jethrokuan/z

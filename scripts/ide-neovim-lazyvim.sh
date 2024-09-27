#! /bin/bash

#
# Inspired from:
# https://github.com/craftzdog/dotfiles-public
#

# Fish Shell https://fishshell.com/
#
uname -a | grep Darwin 2>/dev/null && brew install fish
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  # https://launchpad.net/~fish-shell/+archive/ubuntu/release-3
  if [[ "$ID" == "ubuntu" ]]; then
    apt-add-repository -y ppa:fish-shell/release-3 &&
      apt update &&
      apt install -y fish
  fi
  # Fedora 40 https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A3&package=fish
  if [[ "$ID" == "fedora" ]]; then
    dnf config-manager --add-repo https://download.opensuse.org/repositories/shells:fish:release:3/Fedora_40/shells:fish:release:3.repo &&
      dnf install fish
  fi
fi

# TODO: not working yet
# # Fisher
# #
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
#   source &&
#   fisher install jorgebucaran/fisher

# TODO: do I really need all these ?
# OhMyZsh https://ohmyz.sh/
#
which apt >/dev/null && apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# OhMyBash https://github.com/ohmybash/oh-my-bash
#
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# # Tide https://github.com/ohmybash/oh-my-bash
# #
# fisher install IlanCosman/tide@v6

# FuzzyFinder https://github.com/junegunn/fzf?tab=readme-ov-file#installation
#
uname -a | grep Darwin 2>/dev/null && brew install fzf
which apk 2>/dev/null && apk add fzf
which apt 2>/dev/null && apt install -y fzf
which dnf 2>/dev/null && dnf install -y fzf

# Z (Directory Jumper) for Fish shell https://github.com/jethrokuan/z
#
which fisher 2>/dev/null && fisher install jethrokuan/z

# Eza https://github.com/eza-community/eza/blob/main/INSTALL.md
#
uname -a | grep Darwin 2>/dev/null && brew install eza
if command -v apt && ! command -v eza; then
  apt update && apt install -y gpg
  mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc |
    gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" |
    tee /etc/apt/sources.list.d/gierens.list
  chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  apt update && apt install -y eza
fi

# TODO: add clang on brew
# Compilers
#
uname -a | grep Darwin 2>/dev/null && brew install zig
if [[ -f /etc/os-release ]]; then
  if command -v snap; then
    snap install zig --classic --beta
    apt update && apt install -y build-essential clang cmake
  fi
fi

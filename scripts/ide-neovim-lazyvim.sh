#! /bin/bash

#
# Inspired from:
# https://github.com/craftzdog/dotfiles-public
#

brew_install() {
  uname -a | grep Darwin 2>/dev/null && brew install "$1"
}

apt_install() {
  if command -v apt; then
    sudo apt update
    sudo apt install -y $@
  fi
}

snap_install() {
  if command -v snap; then
    sudo snap install $@
  fi
}

# OS Dependencies

# TabNine
apt_install libgtk-3-dev libglib2.0-dev libjavascriptcoregtk-4.1-dev libsoup-3.0-dev libwebkit2gtk-4.1-dev


# Fish Shell https://fishshell.com/
#
brew_install fish
if command -v apt; then
  sudo apt-add-repository -y ppa:fish-shell/release-3 &&
    sudo apt update &&
    sudo apt install -y fish
fi
# # Fedora 40 https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A3&package=fish
# if [[ "$ID" == "fedora" ]]; then
#   dnf config-manager --add-repo https://download.opensuse.org/repositories/shells:fish:release:3/Fedora_40/shells:fish:release:3.repo &&
#     dnf install fish
# fi

# TODO: not working yet
# # Fisher
# #
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
#   source &&
#   fisher install jorgebucaran/fisher

# TODO: do I really need all these ?
# OhMyZsh https://ohmyz.sh/
#
apt_install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# OhMyBash https://github.com/ohmybash/oh-my-bash
#
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# # Tide https://github.com/ohmybash/oh-my-bash
# #
# fisher install IlanCosman/tide@v6

# Fd https://github.com/sharkdp/fd
#
brew_install fd
if command -v apt; then sudo apt install fd-find; fi

# Ripgrep https://github.com/BurntSushi/ripgrep
#
brew_install ripgrep
apt_install ripgrep

# Lazygit https://github.com/jesseduffield/lazygit
#
brew_install lazygit
if [[ -f /etc/os-release ]]; then
  if command -v apt; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" |
      grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz \
      "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    lazygit --version
  fi
fi

# Lazygit https://rust-analyzer.github.io/
#
brew_install rust-analyzer 2>/dev/null
if [[ -f /etc/os-release ]]; then
  curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz |
    sudo gunzip -c - >/usr/local/bin/rust-analyzer
  sudo chmod +x /usr/local/bin/rust-analyzer
fi

# Node
#
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# uname -a | grep Darwin 2>/dev/null ||
source "$HOME/.nvm/nvm.sh"
nvm install lts/iron && nvm use lts/iron --default

# Luarocks https://luarocks.org/
#
brew_install luarocks
apt_install luarocks

# FuzzyFinder https://github.com/junegunn/fzf?tab=readme-ov-file#installation
#
brew_install fzf
apt_install fzf

# Z (Directory Jumper) for Fish shell https://github.com/jethrokuan/z
#
which fisher 2>/dev/null && fisher install jethrokuan/z

# Eza https://github.com/eza-community/eza/blob/main/INSTALL.md
#
brew_install eza
apt_install gpg
if command -v apt && ! command -v eza; then
  mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc |
    sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" |
    sudo tee /etc/apt/sources.list.d/gierens.list
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
fi
apt_install eza

# TODO: add clang on brew
# Compilers
#
brew_install cmake llvm lua ruby zig
if [[ -f /etc/os-release ]]; then
  snap_install zig --classic --beta
  apt_install build-essential clang cmake lua-any ruby-full
fi

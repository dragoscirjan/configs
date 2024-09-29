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

if uname -a | grep Darwin 2>/dev/null; then4
  packages=(
    # Fish Shell (linux only) https://fishshell.com/
    fish
    # Eza https://github.com/eza-community/eza
    eza
    # Fd https://github.com/sharkdp/fd
    fd
    # FuzzyFinder https://github.com/junegunn/fzf
    fzf
    # Lazygit https://github.com/jesseduffield/lazygit
    lazygit
    # Luarocks https://luarocks.org/
    luarocks
    # Ripgrep https://github.com/BurntSushi/ripgrep
    ripgrep
    # compilers
    cmake llvm lua ruby zig
  )

  brew_install ${packages[@]}
fi

if command -v apt; then
  packages=(
    gpg
    # TabNine
    libgtk-3-dev libglib2.0-dev libjavascriptcoregtk-4.1-dev libsoup-3.0-dev libwebkit2gtk-4.1-dev
    fish
    # Fish Shell https://fishshell.com/
    # OhMyZsh https://ohmyz.sh/
    zsh
    # Fd https://github.com/sharkdp/fd
    fd-find
    # Ripgrep https://github.com/BurntSushi/ripgrep
    ripgrep
    # Lazygit https://rust-analyzer.github.io/
    rust-analyzer 2>/dev/null
    # Luarocks https://luarocks.org/
    luarocks
    # FuzzyFinder https://github.com/junegunn/fzf?tab=readme-ov-file#installation
    fzf
    # compilers
    build-essential clang cmake lua-any ruby-full
  )

  # Fish Shell https://fishshell.com/
  #
  sudo apt-add-repository -y ppa:fish-shell/release-3

  # Eza https://github.com/eza-community/eza/blob/main/INSTALL.md
  #
  mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc |
    sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" |
    sudo tee /etc/apt/sources.list.d/gierens.list
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

  apt_install ${packages[@]}
fi

if command -v snap; then
  # compilers
  #
  snap_install zig --classic --beta
fi

# TODO: not working yet
# # Fisher
# #
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
#   source &&
#   fisher install jorgebucaran/fisher

# OhMyZsh https://ohmyz.sh/
#
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# OhMyBash https://github.com/ohmybash/oh-my-bash
#
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# # Tide https://github.com/ohmybash/oh-my-bash
# #
# fisher install IlanCosman/tide@v6

# Lazygit https://github.com/jesseduffield/lazygit
#
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

# Z (Directory Jumper) for Fish shell https://github.com/jethrokuan/z
#
which fisher 2>/dev/null && fisher install jethrokuan/z

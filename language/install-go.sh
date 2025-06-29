#!/usr/bin/env bash
# Install Go on Linux following https://go.dev/doc/install

set -euo pipefail

go_version="${1:-1.22.4}" # Update to latest if needed
arch="$(uname -m)"
case "$arch" in
x86_64) go_arch="amd64" ;;
aarch64) go_arch="arm64" ;;
armv6l | armv7l) go_arch="armv6l" ;;
*)
  printf "Unsupported architecture: %s\n" "$arch"
  exit 1
  ;;
esac

go_tarball="go${go_version}.linux-${go_arch}.tar.gz"
go_url="https://go.dev/dl/${go_tarball}"
tmp_dir="$(mktemp -d)"
go_install_dir="/usr/local"

trap 'rm -rf "$tmp_dir"' EXIT

printf "Downloading Go %s...\n" "$go_version"
curl -fsSL "$go_url" -o "$tmp_dir/$go_tarball"

printf "Removing any previous Go installation in %s/go...\n" "$go_install_dir"
sudo rm -rf "$go_install_dir/go"

printf "Extracting Go tarball to %s...\n" "$go_install_dir"
sudo tar -C "$go_install_dir" -xzf "$tmp_dir/$go_tarball"

# Add Go to PATH in .bashrc if not already present
[ -f "$HOME/.bashrc" ] && {
  if ! grep -qF "$go_install_dir/go/bin" "$HOME/.bashrc"; then
    printf "Adding Go to PATH in %s/.bashrc\n" "$HOME"
    echo "export PATH=\$PATH:$go_install_dir/go/bin" >>"$HOME/.bashrc"
  fi
}

# Add Go to PATH in .zshrc if not already present
[ -f "$HOME/.zshrc" ] && {
  if ! grep -qF "$go_install_dir/go/bin" "$HOME/.zshrc"; then
    printf "Adding Go to PATH in %s/.zshrc\n" "$HOME"
    echo "export PATH=\$PATH:$go_install_dir/go/bin" >>"$HOME/.zshrc"
  fi
}

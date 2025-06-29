#!/usr/bin/env bash
# Installs Go on Linux following https://go.dev/doc/install
# Downloads the specified Go tarball and installs it system-wide

set -euo pipefail

GO_VERSION="${1:-1.22.4}" # Update to latest if needed
ARCH="$(uname -m)"
case "$ARCH" in
x86_64) GO_ARCH="amd64" ;;
aarch64) GO_ARCH="arm64" ;;
armv6l | armv7l) GO_ARCH="armv6l" ;;
*)
  echo "Unsupported architecture: $ARCH"
  exit 1
  ;;
esac

GO_TARBALL="go${GO_VERSION}.linux-${GO_ARCH}.tar.gz"
GO_URL="https://go.dev/dl/${GO_TARBALL}"
TMP_DIR="$(mktemp -d)"
GO_INSTALL_DIR="/usr/local"

echo "Downloading Go $GO_VERSION..."
curl -fsSL "$GO_URL" -o "$TMP_DIR/$GO_TARBALL"

echo "Removing any previous Go installation in $GO_INSTALL_DIR/go..."
sudo rm -rf "$GO_INSTALL_DIR/go"

echo "Extracting Go tarball to $GO_INSTALL_DIR..."
sudo tar -C "$GO_INSTALL_DIR" -xzf "$TMP_DIR/$GO_TARBALL"

rm -rf "$TMP_DIR"

echo "Go $GO_VERSION installed. Add $GO_INSTALL_DIR/go/bin to your PATH and run 'go version' to verify."

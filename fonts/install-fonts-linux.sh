#!/bin/bash

# Usage: ./install-fonts-linux.sh <font-url1> <font-url2> ...

# Check if at least one URL is provided
if [ $# -eq 0 ]; then
  echo "No font URLs provided. Usage: ./install_fonts_ubuntu.sh <font-url1> <font-url2> ..."
  exit 1
fi

# Font installation directory
FONT_DIR="$HOME/.local/share/fonts"

# Create the directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Download and install each font
for url in "$@"
do
  echo "Downloading font from $url ..."
  wget -O /tmp/font.zip "$url"
  unzip /tmp/font.zip -d "$FONT_DIR"
  rm /tmp/font.zip
  echo "Installed font from $url"
done

# Refresh the font cache
fc-cache -fv

echo "All fonts installed successfully!"

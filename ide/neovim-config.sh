#!/usr/bin/env bash
#
# Script to link the neovim-config folder to ~/.config/nvim.

set -e
set -o pipefail

# Main function to setup neovim configuration
main() {
  # Get the directory where this script is located
  readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  readonly CONFIG_SOURCE="${SCRIPT_DIR}/neovim-config"
  readonly CONFIG_TARGET="${HOME}/.config/nvim"

  # Make sure ~/.config exists
  if [[ ! -d "${HOME}/.config" ]]; then
    echo "Creating ~/.config directory"
    mkdir -p "${HOME}/.config"
  fi

  # Check if source directory exists
  if [[ ! -d "${CONFIG_SOURCE}" ]]; then
    echo "ERROR: Source directory ${CONFIG_SOURCE} does not exist." >&2
    exit 1
  fi

  # Backup existing nvim config if it exists
  if [[ -d "${CONFIG_TARGET}" || -L "${CONFIG_TARGET}" ]]; then
    readonly TIMESTAMP="$(date +%s)"
    readonly BACKUP_NAME="${HOME}/.config/nvim.bak.${TIMESTAMP}"
    readonly BACKUP_ZIP="${HOME}/.config/nvim.bak.${TIMESTAMP}.zip"

    echo "Backing up existing nvim config to ${BACKUP_NAME}"
    mv "${CONFIG_TARGET}" "${BACKUP_NAME}"

    echo "Creating zip archive of backup at ${BACKUP_ZIP}"
    (cd "$(dirname "${BACKUP_NAME}")" && zip -rq "$(basename "${BACKUP_ZIP}")" "$(basename "${BACKUP_NAME}")") || {
      echo "ERROR: Failed to create backup zip. Original backup folder preserved at ${BACKUP_NAME}" >&2
      exit 1
    }

    echo "Removing backup folder"
    rm -rf "${BACKUP_NAME}"

    echo "Backup saved to ${BACKUP_ZIP}"
  fi

  # Create the symlink
  echo "Linking ${CONFIG_SOURCE} to ${CONFIG_TARGET}"
  ln -sf "${CONFIG_SOURCE}" "${CONFIG_TARGET}"

  echo "NeoVim configuration setup complete!"
  echo "Source: ${CONFIG_SOURCE}"
  echo "Target: ${CONFIG_TARGET}"

  return 0
}

# Execute main function
main "$@"

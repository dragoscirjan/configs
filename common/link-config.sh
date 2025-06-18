#!/bin/bash
# Generic link-config.sh

set -e

# Function to show usage
usage() {
    echo "Usage: $0 <source> <destination>"
    echo "  source:      Path to source file or directory"
    echo "  destination: Path to destination where symlink will be created"
    echo "  Use __HOME__ as placeholder for home directory"
    exit 1
}

# Check if we have the required arguments
if [ $# -ne 2 ]; then
    usage
fi

SOURCE="$1"
DESTINATION="$2"

# Generate timestamp for backup files
timestamp=$(date +%s)

# Replace __HOME__ placeholder with actual home directory
SOURCE="${SOURCE//__HOME__/$HOME}"
DESTINATION="${DESTINATION//__HOME__/$HOME}"

# Check if source exists
if [ ! -e "$SOURCE" ]; then
    echo "» Source path '$SOURCE' does not exist." >&2
    exit 1
fi

# Ensure parent directory of destination exists
PARENT_DIR=$(dirname "$DESTINATION")
if [ -n "$PARENT_DIR" ] && [ ! -d "$PARENT_DIR" ]; then
    echo "» Creating parent directory: $PARENT_DIR"
    mkdir -p "$PARENT_DIR"
elif [ -n "$PARENT_DIR" ] && [ -e "$PARENT_DIR" ] && [ ! -d "$PARENT_DIR" ]; then
    echo "» Parent path '$PARENT_DIR' exists but is not a directory." >&2
    exit 1
fi

# Backup destination if it exists
if [ -e "$DESTINATION" ]; then
    backup="$DESTINATION.bak.$timestamp"
    echo "» Backing up existing $DESTINATION to $backup"
    mv "$DESTINATION" "$backup"
fi

# Determine if source is file or directory
if [ -d "$SOURCE" ]; then
    item_type="directory"
else
    item_type="file"
fi

echo "» Linking $SOURCE to $DESTINATION as $item_type symbolic link"
ln -sf "$SOURCE" "$DESTINATION"

#!/bin/bash
# Deprecated: Use 'task update:config:link' instead
# This script is kept for backward compatibility

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <source> <destination>"
    echo ""
    echo "This script is deprecated. Please use:"
    echo "  task update:config:link SOURCE=<source> DESTINATION=<destination>"
    exit 1
fi

SOURCE="$1"
DESTINATION="$2"

echo "» Redirecting to Taskfile task..."
task update:config:link SOURCE="${SOURCE}" DESTINATION="${DESTINATION}"

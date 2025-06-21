# Determine the directory of this script
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"

# Only initialize Oh My Posh if not running in Apple Terminal
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init bash --config $SCRIPT_DIR/ohmyposh.config.toml)"
fi

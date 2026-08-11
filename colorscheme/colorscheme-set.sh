#!/usr/bin/env bash
set -e

# Usage check
if [ -z "$1" ]; then
  echo "Usage: $0 <colorscheme-profile>" >&2
  exit 1
fi

profile="$1"

# Load environment variables
source "$HOME/dotfiles/colorscheme/colorscheme_env.sh"
colorscheme_env_init "$profile"

# Ensure the colorscheme file exists
if [ ! -f "$COLORSCHEME_FILE" ]; then
  echo "Colorscheme file '$COLORSCHEME_FILE' does not exist." >&2
  exit 1
fi

# Compare and update
if ! cmp -s "$COLORSCHEME_FILE" "$ACTIVE_FILE"; then
  echo "Updating active colorscheme to '$profile'..."
  cp "$COLORSCHEME_FILE" "$ACTIVE_FILE"

  # Source all config generators
  for config_script in "$HOME/dotfiles/colorscheme/configs/"*.sh; do
    [ -f "$config_script" ] && source "$config_script"
  done

  ghostty_generate_config "$ACTIVE_FILE" "$GHOSTTY_CONF_FILE"
  ghostty_reload_config
  tmux_generate_config "$TMUX_CONF_FILE"
  tmux_reload_config
  nvim_generate_config "$ACTIVE_FILE" "$NVIM_PALETTE_FILE"
  nvim_reload_config


# Set the wallpaper
  wallpaper=$(grep -E '^\s*wallpaper\s*=' "$COLORSCHEME_FILE" | sed -E 's/.*"\s*([^"]+)\s*".*/\1/')
  if [ -z "$wallpaper" ]; then
    wallpaper="default.jpg"
  fi
  wallpaper_path="$WALLPAPER_DIR/$wallpaper"
  osascript -e '
  tell application "System Events"
      repeat with d in desktops
          set picture of d to "'"$wallpaper_path"'"
      end repeat
  end tell'
else
  echo "Colorscheme '$profile' is already active."
fi


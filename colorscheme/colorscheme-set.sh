#!/usr/bin/env bash

# Filename: ~/dotfiles/colorscheme/colorscheme-set.sh
# ~/dotfiles/colorscheme/colorscheme-set.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display error messages
error() {
  echo "Error: $1" >&2
  exit 1
}

# Ensure a colorscheme profile is provided
if [ -z "$1" ]; then
  error "No colorscheme profile provided"
fi

colorscheme_profile="$1"

# Define paths
colorscheme_file="$HOME/dotfiles/colorscheme/themes/$colorscheme_profile"
active_file="$HOME/dotfiles/colorscheme/active/theme.toml"

# Check if the colorscheme file exists
if [ ! -f "$colorscheme_file" ]; then
  error "Colorscheme file '$colorscheme_file' does not exist."
fi

# If active-colorscheme.sh doesn't exist, create it
if [ ! -f "$active_file" ]; then
  echo "Active colorscheme file not found. Creating '$active_file'."
  cp "$colorscheme_file" "$active_file"
  UPDATED=true
else
  # Compare the new colorscheme with the active one
  if ! diff -q "$active_file" "$colorscheme_file" >/dev/null; then
    UPDATED=true
  else
    UPDATED=false
  fi
fi

# Source all config files
for config_file in "$HOME/dotfiles/colorscheme/configs/"*.sh; do
  [ -f "$config_file" ] && source "$config_file"
done

# If there's an update, replace the active colorscheme and perform necessary actions
if [ "$UPDATED" = true ]; then
  echo "Updating active colorscheme to '$colorscheme_profile'."

  # Replace the contents of active colorscheme
  cp "$colorscheme_file" "$active_file"

  # Source the active colorscheme to load variables
  # source "$active_file"

  # Generate the ghostty config file
  ghostty_generate_config
  ghostty_reload_config

  # Generate the tmux config file
  tmux_generate_config
  tmux_reload_config

  # Generate the nvim config file
  nvim_generate_config && nvim_reload_config

  # Set the wallpaper
  # if [ -z "$wallpaper" ]; then
  #   wallpaper="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Images/wallpapers/default.jpg"
  # fi
  # osascript -e '
  # tell application "System Events"
  #     repeat with d in desktops
  #         set picture of d to "'"$wallpaper"'"
  #     end repeat
  # end tell'

fi
echo "Colorscheme updated."

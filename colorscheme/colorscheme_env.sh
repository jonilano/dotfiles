# ~/dotfiles/colorscheme/colorscheme_env.sh

colorscheme_env_init() {
  # if [ -z "$1" ]; then
  #   echo "Error: colorscheme_profile not provided" >&2
  #   return 1
  # fi

  local profile="${1:-catppuccin-moccha.toml}"
  local base_dir="$HOME/dotfiles/colorscheme"

  COLORSCHEME_PROFILE="$profile"
  COLORSCHEME_FILE="$base_dir/themes/$profile"
  ACTIVE_FILE="$base_dir/active/theme.toml"
  WALLPAPER_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Images/wallpapers"
  TMUX_CONF_FILE="$HOME/dotfiles/tmux/tmux-theme"
  GHOSTTY_CONF_FILE="$HOME/dotfiles/ghostty/themes/ghostty-theme"
  NVIM_PALETTE_FILE="$HOME/dotfiles/nvim/lua/config/palette.lua"
}

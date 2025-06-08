#!/usr/bin/env bash

# Load environment variables
source "$HOME/dotfiles/colorscheme/colorscheme_env.sh"
colorscheme_env_init


# Source all config generators
for config_script in "$HOME/dotfiles/colorscheme/configs/"*.sh; do
[ -f "$config_script" ] && source "$config_script"
done

ghostty_toggle_transparency
ghostty_reload_config
tmux_reload_config
nvim_reload_config

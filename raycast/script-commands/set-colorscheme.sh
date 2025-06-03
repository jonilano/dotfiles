#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Colorscheme
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }
# @raycast.packageName Terminal

# Documentation:
# @raycast.description Set colorscheme
# @raycast.author jonilano
# @raycast.authorURL https://raycast.com/jonilano

COLORSCHEME_SELECTOR="$HOME/dotfiles/colorscheme/colorscheme-set.sh"
"$COLORSCHEME_SELECTOR" "$1.toml"

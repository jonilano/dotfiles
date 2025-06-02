
nvim_reload_config() {
  # Neovim stores its server socket in a dynamically assigned directory on macOS.
  # This path may vary between reboots or user sessions, so adjust if needed.
  local SOCKET_DIR="/var/folders/kg/rkf58zlx2h71wh2g5m0gpjkr0000gn/T/nvim.jonilano"

  # Find all active Neovim server sockets in the target directory
  # and iterate over each one to send reload commands.
  find "$SOCKET_DIR" -type s -name 'nvim*' | while IFS= read -r sock; do
    echo "Sending reload commands to Neovim server: $sock"

    # Call the user-defined Lua function ReloadPalette()
    # (should be defined in your Lua config, e.g., utils/ui.lua)
    nvim --server "$sock" --remote-send ':lua ReloadPalette()<CR>'

    # Re-source the main Neovim configuration file (init.lua or init.vim)
    nvim --server "$sock" --remote-send ':source $MYVIMRC<CR>'
    nvim --server "$sock" --remote-send ':echo "Config Reloaded!"<CR>'
  done
}

nvim_generate_config() {

  local INPUT_FILE="$HOME/dotfiles/colorscheme/active/theme.toml"
  local OUTPUT_FILE="$HOME/dotfiles/nvim/lua/config/palette.lua"

  echo "return {" > "$OUTPUT_FILE"

  current_section=""
  first_section=true

  while IFS= read -r line || [[ -n "$line" ]]; do
    line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    # Section headers like [nvim]
    if [[ "$line" =~ ^\[(.+)\]$ ]]; then
      if [ "$first_section" = false ]; then
        echo "  }," >> "$OUTPUT_FILE"
      else
        first_section=false
      fi
      current_section="${BASH_REMATCH[1]}"
      echo "  $current_section = {" >> "$OUTPUT_FILE"
      continue
    fi

    # Simple key = "value"
    if [[ "$line" =~ ^([a-zA-Z0-9_]+)[[:space:]]*=[[:space:]]*\"([^\"]+)\"$ ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      echo "    $key = \"$value\"," >> "$OUTPUT_FILE"
      continue
    fi

    # Inline table: key = { ... }
    if [[ "$line" =~ ^([a-zA-Z0-9_]+)[[:space:]]*=[[:space:]]*\{(.*)\}$ ]]; then
      key="${BASH_REMATCH[1]}"
      kv_pairs="${BASH_REMATCH[2]}"
      lua_table=""

      IFS=',' read -ra entries <<< "$kv_pairs"
      for pair in "${entries[@]}"; do
        pair=$(echo "$pair" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        if [[ "$pair" =~ ^([a-zA-Z0-9_]+)[[:space:]]*=[[:space:]]*\"([^\"]+)\"$ ]]; then
          subkey="${BASH_REMATCH[1]}"
          subvalue="${BASH_REMATCH[2]}"
          lua_table+=" $subkey = \"$subvalue\","
        fi
      done
      lua_table=$(echo "$lua_table" | sed 's/,\s*$//')
      echo "    $key = { $lua_table }," >> "$OUTPUT_FILE"
      continue
    fi

  done < "$INPUT_FILE"

  echo "  }" >> "$OUTPUT_FILE"
  echo "}" >> "$OUTPUT_FILE"
}

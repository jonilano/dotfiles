#!/usr/bin/env bash

# nvim_generate_config() {
#
#   local INPUT_FILE="$HOME/dotfiles/colorscheme/active/theme.toml"
#   local OUTPUT_FILE="$HOME/dotfiles/nvim/lua/config/palette.lua"
#
#   echo "return {" > "$OUTPUT_FILE"
#
#   current_section=""
#   first_section=true
#
#   while IFS= read -r line || [[ -n "$line" ]]; do
#     line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
#     [[ -z "$line" || "$line" =~ ^# ]] && continue
#
#     if [[ "$line" =~ ^\[(.+)\]$ ]]; then
#       if [ "$first_section" = false ]; then
#         echo "  }," >> "$OUTPUT_FILE"
#       else
#         first_section=false
#       fi
#       current_section="${BASH_REMATCH[1]}"
#       echo "  $current_section = {" >> "$OUTPUT_FILE"
#       continue
#     fi
#
#     # Match simple quoted string
#     if [[ "$line" =~ ^([a-zA-Z0-9_]+)[[:space:]]*=[[:space:]]*\"(#[a-fA-F0-9]+)\" ]]; then
#       key="${BASH_REMATCH[1]}"
#       value="${BASH_REMATCH[2]}"
#       echo "    $key = \"$value\"," >> "$OUTPUT_FILE"
#       continue
#     fi
#
#     # Match inline table like menu = { bg = "#0f857c", fg = "#987afb" }
#     if [[ "$line" =~ ^([a-zA-Z0-9_]+)[[:space:]]*=[[:space:]]*\{(.*)\}$ ]]; then
#       key="${BASH_REMATCH[1]}"
#       kv_pairs="${BASH_REMATCH[2]}"
#       lua_table=""
#
#       # Convert each key="value" in the inline table
#       IFS=',' read -ra entries <<< "$kv_pairs"
#       for pair in "${entries[@]}"; do
#         pair=$(echo "$pair" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
#         if [[ "$pair" =~ ^([a-zA-Z0-9_]+)[[:space:]]*=[[:space:]]*\"(#[a-fA-F0-9]+)\"$ ]]; then
#           subkey="${BASH_REMATCH[1]}"
#           subvalue="${BASH_REMATCH[2]}"
#           lua_table+=" $subkey = \"$subvalue\","
#         fi
#       done
#       # Trim trailing comma and wrap in {}
#       lua_table=$(echo "$lua_table" | sed 's/,\s*$//')
#       echo "    $key = { $lua_table }," >> "$OUTPUT_FILE"
#       continue
#     fi
#
#   done < "$INPUT_FILE"
#
#   echo "  }" >> "$OUTPUT_FILE"
#   echo "}" >> "$OUTPUT_FILE"
# }





#!/usr/bin/env bash

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

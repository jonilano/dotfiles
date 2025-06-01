ghostty_reload_config() {
  osascript $HOME/dotfiles/ghostty/reload-config.scpt
}

ghostty_generate_config() {
  # Path to output Ghostty theme configuration file
  ghostty_conf_file="$HOME/dotfiles/ghostty/themes/ghostty-theme"

  # Path to the source TOML theme file
  THEME_FILE="$HOME/dotfiles/colorscheme/active/theme.toml"

  # Use awk to process the TOML file and convert it to Ghostty-compatible format
  awk '
    # When entering [ansi] section, set in_ansi flag
    /^\[ansi\]/ {
      in_ansi = 1
      next  # Skip processing this line further
    }

    # When entering [ui] section, set in_ui flag and unset in_ansi
    /^\[ui\]/ {
      in_ansi = 0
      in_ui = 1
      next
    }

    # If another section is encountered, disable both flags
    /^\[/ && !/^\[ansi\]/ && !/^\[ui\]/ {
      in_ansi = 0
      in_ui = 0
    }

    # Process ansi_XX color definitions (only if in [ansi] section)
    in_ansi && /^ansi_/ {
      color = $3                 # Get the color value (e.g., "#123456")
      gsub(/"/, "", color)       # Remove double quotes from color
      idx = substr($1, 6) + 0    # Extract index from 'ansi_00' → '00' → numeric
      print "palette = " idx "=" color  # Output in Ghostty format
    }

    # Process background color (only if in [ui] section)
    in_ui && /^background/ {
      color = $3
      gsub(/"/, "", color)
      print "background = " color
    }

    # Process foreground color (only if in [ui] section)
    in_ui && /^foreground/ {
      color = $3
      gsub(/"/, "", color)
      print "foreground = " color
    }

    # Process cursor color (only if in [ui] section)
    in_ui && /^cursor/ {
      color = $3
      gsub(/"/, "", color)
      print "cursor-color = " color
    }

    # Process selection background (only if in [ui] section)
    in_ui && /^selection_background/ {
      color = $3
      gsub(/"/, "", color)
      print "selection-background = " color
    }

    # Process selection foreground (only if in [ui] section)
    in_ui && /^selection_foreground/ {
      color = $3
      gsub(/"/, "", color)
      print "selection-foreground = " color
    }
  ' "$THEME_FILE" > "$ghostty_conf_file"  # Run AWK and redirect output to Ghostty theme file

  # Notify the user
  echo "Ghostty configuration updated at '$ghostty_conf_file'."
}

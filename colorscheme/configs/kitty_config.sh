kitty_reload_config() {
    kill -SIGUSR1 "$(pgrep -x kitty)"
}

kitty_generate_config() {
  kitty_conf_file="$HOME/dotfiles/kitty/active-theme.conf"

  cat >"$kitty_conf_file" <<EOF
foreground            $linkarzu_color14
background            $linkarzu_color07
selection_foreground  $linkarzu_color14
selection_background   $linkarzu_color16
url_color             $linkarzu_color03
# black
color0                $linkarzu_color10
color8                $linkarzu_color08
# red
color1                $linkarzu_color11
color9                $linkarzu_color11
# green
color2                $linkarzu_color02
color10               $linkarzu_color02
# yellow
color3                $linkarzu_color05
color11               $linkarzu_color05
# blue
color4                $linkarzu_color04
color12               $linkarzu_color04
# magenta
color5                $linkarzu_color01
color13               $linkarzu_color01
# cyan
color6                $linkarzu_color03
color14               $linkarzu_color03
# white
color7                $linkarzu_color14
color15               $linkarzu_color14
# Cursor colors
cursor                $linkarzu_color24
cursor_text_color     $linkarzu_color24
# Tab bar colors
active_tab_foreground  $linkarzu_color10
active_tab_background   $linkarzu_color02
inactive_tab_foreground $linkarzu_color03
inactive_tab_background $linkarzu_color10
# Marks
mark1_foreground      $linkarzu_color10
mark1_background      $linkarzu_color11
# Splits/Windows
active_border_color   $linkarzu_color04
inactive_border_color  $linkarzu_color10
EOF

  echo "Kitty configuration updated at '$kitty_conf_file'."
}

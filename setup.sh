#!/bin/bash

# Variables
dotfiles_dir="$HOME/dotfiles"
home_dir="$HOME"
config_dir="$HOME/.config"

dotfiles=(.gitconfig .vimrc .zshrc .zshrc.local)
config_dirs=(ghostty tmux nvim btop karabiner)

is_managed_file() {
  local file="$1"
  for managed in "${dotfiles[@]}" "${config_dirs[@]}"; do
    if [[ "$file" == "$managed" ]]; then
      return 0
    fi
  done
  return 1
}

create_symlink() {
  local file="$1"
  if [[ " ${dotfiles[*]} " == *" $file "* ]]; then
    echo "Creating symlink for $file in home directory..."
    if [ -f "$home_dir/$file" ] || [ -L "$home_dir/$file" ]; then
      echo "Backing up existing $file to $file.bak"
      mv "$home_dir/$file" "$home_dir/$file.bak"
    fi
    ln -sf "$dotfiles_dir/$file" "$home_dir/$file"
  elif [[ " ${config_dirs[*]} " == *" $file "* ]]; then
    echo "Creating symlink for $file in .config directory..."
    if [ -e "$config_dir/$file" ] || [ -L "$config_dir/$file" ]; then
      echo "Backing up existing $file to $file.bak"
      mv "$config_dir/$file" "$config_dir/$file.bak"
    fi
    ln -sf "$dotfiles_dir/$file" "$config_dir/$file"
  fi
  echo "Symlinked $file"
}

remove_symlink() {
  local file="$1"
  if [[ " ${dotfiles[*]} " == *" $file "* ]]; then
    if [ -L "$home_dir/$file" ]; then
      rm "$home_dir/$file"
      echo "Removed symlink for $file from home"
    else
      echo "No symlink found for $file in home"
    fi
  elif [[ " ${config_dirs[*]} " == *" $file "* ]]; then
    if [ -L "$config_dir/$file" ]; then
      rm "$config_dir/$file"
      echo "Removed symlink for $file from .config"
    else
      echo "No symlink found for $file in .config"
    fi
  fi
}

install_all() {
  echo "Creating symlinks for all dotfiles and config directories..."
  for file in "${dotfiles[@]}"; do
    create_symlink "$file"
  done
  for dir in "${config_dirs[@]}"; do
    create_symlink "$dir"
  done
}

clean_all() {
  echo "Removing symlinks for all dotfiles and config directories..."
  for file in "${dotfiles[@]}"; do
    remove_symlink "$file"
  done
  for dir in "${config_dirs[@]}"; do
    remove_symlink "$dir"
  done
}

usage() {
  echo "Usage: $0 {install|clean|install FILE|clean FILE}"
  echo "Managed dotfiles: ${dotfiles[*]}"
  echo "Managed config dirs: ${config_dirs[*]}"
  exit 1
}

# Argument handling
if [ "$#" -eq 1 ]; then
  case "$1" in
  install)
    install_all
    ;;
  clean)
    clean_all
    ;;
  *)
    usage
    ;;
  esac
elif [ "$#" -eq 2 ]; then
  case "$1" in
  install | clean)
    if is_managed_file "$2"; then
      if [ "$1" == "install" ]; then
        create_symlink "$2"
      else
        remove_symlink "$2"
      fi
    else
      echo "Error: '$2' is not managed."
      echo "Managed dotfiles: ${dotfiles[*]}"
      echo "Managed config dirs: ${config_dirs[*]}"
      exit 1
    fi
    ;;
  *)
    usage
    ;;
  esac
else
  usage
fi

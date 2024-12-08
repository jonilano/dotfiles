#!/bin/bash

# Variables
dotfiles_dir="$HOME/dotfiles"
home_dir="$HOME"
dotfiles=(.zshrc .gitconfig)

create_symlinks() {
  echo "Creating symlinks for dotfiles..."
  for file in "${dotfiles[@]}"; do
    if [ -f "$home_dir/$file" ] || [ -L "$home_dir/$file" ]; then
      echo "Backing up existing $file to $file.bak"
      mv "$home_dir/$file" "$home_dir/$file.bak"
    fi
    ln -sf "$dotfiles_dir/$file" "$home_dir/$file"
    echo "Symlinked $file"
  done
}

remove_symlinks() {
  echo "Removing symlinks for dotfiles..."
  for file in "${dotfiles[@]}"; do
    if [ -L "$home_dir/$file" ]; then
      rm "$home_dir/$file"
      echo "Removed symlink for $file"
    fi
  done
}

usage() {
  echo "Usage: $0 {install|clean}"
  exit 1
}

if [ "$#" -ne 1 ]; then
  usage
fi

case "$1" in
  install)
    create_symlinks
    ;;
  clean)
    remove_symlinks
    ;;
  *)
    usage
    ;;
esac


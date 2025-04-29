#!/bin/bash

# Variables
dotfiles_dir="$HOME/dotfiles"
home_dir="$HOME"
dotfiles=(.gitconfig .vimrc .zshrc .zshrc.local)

is_managed_file() {
  local file="$1"
  for managed in "${dotfiles[@]}"; do
    if [[ "$file" == "$managed" ]]; then
      return 0
    fi
  done
  return 1
}

create_symlink() {
  local file="$1"
  echo "Creating symlink for $file..."
  if [ -f "$home_dir/$file" ] || [ -L "$home_dir/$file" ]; then
    echo "Backing up existing $file to $file.bak"
    mv "$home_dir/$file" "$home_dir/$file.bak"
  fi
  ln -sf "$dotfiles_dir/$file" "$home_dir/$file"
  echo "Symlinked $file"
}

remove_symlink() {
  local file="$1"
  if [ -L "$home_dir/$file" ]; then
    rm "$home_dir/$file"
    echo "Removed symlink for $file"
  else
    echo "No symlink found for $file"
  fi
}

install_all() {
  echo "Creating symlinks for all dotfiles..."
  for file in "${dotfiles[@]}"; do
    create_symlink "$file"
  done
}

clean_all() {
  echo "Removing symlinks for all dotfiles..."
  for file in "${dotfiles[@]}"; do
    remove_symlink "$file"
  done
}

usage() {
  echo "Usage: $0 {install|clean|install FILE|clean FILE}"
  echo "Managed dotfiles: ${dotfiles[*]}"
  exit 1
}

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

# Makefile for managing dotfiles symlinks

# Variables
dotfiles_dir := $(HOME)/dotfiles
home_dir := $(HOME)

dotfiles := .zshrc .gitconfig

.PHONY: all install clean

# Default target
all: install

# Create symlinks in the home directory
install:
	@echo "Creating symlinks for dotfiles..."
	@for file in $(dotfiles); do \
		if [ -f $(home_dir)/$$file ] || [ -L $(home_dir)/$$file ]; then \
			echo "Backing up existing $$file to $$file.bak"; \
			mv $(home_dir)/$$file $(home_dir)/$$file.bak; \
		fi; \
		ln -sf $(dotfiles_dir)/$$file $(home_dir)/$$file; \
		echo "Symlinked $$file"; \
	done

# Remove symlinks
clean:
	@echo "Removing symlinks for dotfiles..."
	@for file in $(dotfiles); do \
		if [ -L $(home_dir)/$$file ]; then \
			rm $(home_dir)/$$file; \
			echo "Removed symlink for $$file"; \
		fi; \
	done


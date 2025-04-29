# Makefile for managing dotfiles symlinks

# Variables
dotfiles_dir := $(HOME)/dotfiles
home_dir := $(HOME)

dotfiles := .gitconfig .vimrc .zshrc .zshrc.local

.PHONY: all install clean $(dotfiles) clean-$(dotfiles)

# Default target
all: install

# Install all dotfiles
install: $(dotfiles)

# Install individual dotfile (make .zshrc, make .vimrc, etc.)
$(dotfiles):
	@echo "Creating symlink for $@..."
	@if [ -f $(home_dir)/$@ ] || [ -L $(home_dir)/$@ ]; then \
		echo "Backing up existing $@ to $@.bak"; \
		mv $(home_dir)/$@ $(home_dir)/$@.bak; \
	fi
	@ln -sf $(dotfiles_dir)/$@ $(home_dir)/$@
	@echo "Symlinked $@"

# Remove all dotfiles
clean:
	@echo "Removing symlinks for dotfiles..."
	@for file in $(dotfiles); do \
		if [ -L $(home_dir)/$$file ]; then \
			rm $(home_dir)/$$file; \
			echo "Removed symlink for $$file"; \
		fi; \
	done

# Remove individual dotfile (make clean-.zshrc, make clean-.vimrc, etc.)
clean-%:
	@file=$*; \
	if [ -L $(home_dir)/$$file ]; then \
		rm $(home_dir)/$$file; \
		echo "Removed symlink for $$file"; \
	else \
		echo "No symlink found for $$file"; \
	fi


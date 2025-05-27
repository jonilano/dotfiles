# Makefile for managing dotfiles and config folder symlinks

# Variables
dotfiles_dir := $(HOME)/dotfiles
home_dir := $(HOME)
config_dir := $(HOME)/.config

dotfiles := .gitconfig .vimrc .zshrc .zshrc.local
config_dotfiles := ghostty nvim btop karabiner

# Combine all valid targets
all_targets := $(dotfiles) $(config_dotfiles)

.PHONY: all install clean config-dirs $(all_targets) clean-%

# Default target
all: install

# Install all dotfiles and config directories
install: $(all_targets)

# Handle dotfiles
$(dotfiles):
	@echo "Creating symlink for $@ in home directory..."
	@if [ -f $(home_dir)/$@ ] || [ -L $(home_dir)/$@ ]; then \
		echo "Backing up existing $@ to $@.bak"; \
		mv $(home_dir)/$@ $(home_dir)/$@.bak; \
	fi
	@ln -sf $(dotfiles_dir)/$@ $(home_dir)/$@
	@echo "Symlinked $@"

# Handle config directories
$(config_dotfiles):
	@echo "Creating symlink for $@ in .config directory..."
	@if [ -e $(config_dir)/$@ ] || [ -L $(config_dir)/$@ ]; then \
		echo "Backing up existing $@ to $@.bak"; \
		mv $(config_dir)/$@ $(config_dir)/$@.bak; \
	fi
	@ln -sf $(dotfiles_dir)/$@ $(config_dir)/$@
	@echo "Symlinked $@"

# Remove all dotfiles and config dirs
clean:
	@echo "Removing symlinks for dotfiles..."
	@for file in $(dotfiles); do \
		if [ -L $(home_dir)/$$file ]; then \
			rm $(home_dir)/$$file; \
			echo "Removed symlink for $$file"; \
		fi; \
	done
	@echo "Removing symlinks for config dirs..."
	@for dir in $(config_dotfiles); do \
		if [ -L $(config_dir)/$$dir ]; then \
			rm $(config_dir)/$$dir; \
			echo "Removed symlink for $$dir"; \
		fi; \
	done

# Remove individual symlink (dotfile or config dir)
clean-%:
	@name=$*; \
	if [ -L $(home_dir)/$$name ]; then \
		rm $(home_dir)/$$name; \
		echo "Removed symlink for $$name in home directory"; \
	elif [ -L $(config_dir)/$$name ]; then \
		rm $(config_dir)/$$name; \
		echo "Removed symlink for $$name in .config directory"; \
	else \
		echo "No symlink found for $$name"; \
	fi

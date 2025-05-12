# Enable Vim keybindings
bindkey -v

# Map 'jk' to ESC in insert mode
bindkey -M viins 'jk' vi-cmd-mode

# Enable colors for `ls` and other commands
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxExcxabagaced

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

# Aliases for convenience
alias l="ls -a"
alias ll="ls -la"

# Source additional user-specific configuration if it exists
# This allows for system-specific customizations without modifying the main configuration
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


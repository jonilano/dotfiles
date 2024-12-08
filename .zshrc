# Enable Vim keybindings
bindkey -v

# Map 'jk' to ESC in insert mode
bindkey -M viins 'jk' vi-cmd-mode

# Set a simple prompt (user@host:cwd$)
PROMPT='%F{cyan}%n@%m%f:%F{green}%~%f$ '

# Export PATH (add custom paths if needed)
# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Enable colors for `ls` and other commands
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

# Aliases for convenience
alias l="ls -a"
alias ll="ls -la"

# Terminal detection for Kitty
if [[ $TERM == "xterm-kitty" ]]; then
    export TERM="xterm-kitty"
fi

# Source additional user-specific configuration if it exists
# This allows for system-specific customizations without modifying the main configuration
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


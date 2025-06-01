# Enable Vim keybindings
bindkey -v

# Map 'jk' to ESC in insert mode
# bindkey -M viins 'jk' vi-cmd-mode

export EDITOR=nvim

# Enable colors for `ls` and other commands
export CLICOLOR=1
# directory,symlink,socket,pipe,exec,block,char,exec_suid,exec_sgid,dir_sticky,dir_w/o_sticky,datalessfile
# export LSCOLORS=GxFxCxDxBxExcxabagaced
export LSCOLORS=GxFxCxDxExBxcxabagaced

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


# Enable Vim keybindings
bindkey -v

# Map 'jk' to ESC in insert mode
# bindkey -M viins 'jk' vi-cmd-mode

# Set a simple prompt (user@host:cwd$)
PROMPT='%F{cyan}%n@%m%f:%F{green}%~%f$ '

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

# fzf
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
 --walker-skip .git,node_modules,target
 --preview 'bat -n --color=always {}'
 --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# Source additional user-specific configuration if it exists
# This allows for system-specific customizations without modifying the main configuration
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

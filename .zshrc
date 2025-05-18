# Enable Vim keybindings
bindkey -v

# Map 'jk' to ESC in insert mode
# bindkey -M viins 'jk' vi-cmd-mode

export EDITOR=nvim

setopt PROMPT_SUBST

USERHOST_COLOR=""
DIR_COLOR="%F{cyan}"
GITBRANCH_COLOR="%F{magenta}"
GITSTATUS_COLOR="%F{red}"
PROMPT_SYMBOL_COLOR=""

COLOR_RESET="%f"

git_branch() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    # Try to get the current branch
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)

    if [[ -z $branch ]]; then
      # Not on a branch — check for tag, otherwise use short SHA
      local tag=$(git describe --tags --exact-match 2>/dev/null)
      local sha=$(git rev-parse --short HEAD 2>/dev/null)
      if [[ -n $tag ]]; then
        branch="detached@$tag"
      else
        branch="detached@$sha"
      fi
    fi

    echo "$branch"
  fi
}

git_status_flags() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local git_status_output=$(git status --porcelain 2>/dev/null)
    local flags=""

    if echo "$git_status_output" | grep -q '^[ MARC]'; then
      flags+="!"
    fi

    if echo "$git_status_output" | grep -q '^??'; then
      flags+="?"
    fi

    if [[ -n $flags ]]; then
      echo "[$flags]"
    fi
  fi
}

PROMPT='${USERHOST_COLOR}%n@%m${COLOR_RESET} '${DIR_COLOR}'%1~'${COLOR_RESET}'$(b=$(git_branch); [[ -n $b ]] && echo " ${GITBRANCH_COLOR}($b)${COLOR_RESET}")'\
'$(s=$(git_status_flags); [[ -n $s ]] && echo " ${GITSTATUS_COLOR}$s${COLOR_RESET}")'\
' ${PROMPT_SYMBOL_COLOR}# ${COLOR_RESET}'

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


# ~/.bashrc: executed by bash(1) for non-login shells.

export PATH="$HOME/bin:$HOME/go/bin:$PATH"
export PATH="$PATH:/usr/local/bin"

case $- in
    *i*) ;; # Interactive shell
    *) return ;; # Non-interactive shell - exit early
esac

# History settings
HISTCONTROL=ignorespace
shopt -s histappend
HISTSIZE=10000000
HISTFILESIZE=200000000
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -n"

# Load Git completion and prompt scripts
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_SHOWUNTRACKEDFILES=yes
GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_SHOWSTASHSTATE=yes
GIT_PS1_SHOWCOLORHINTS=yes

# Try to load Git prompt from various locations
if command -v brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix 2>/dev/null || echo "/usr/local")
    if [ -f "$BREW_PREFIX/etc/bash_completion.d/git-completion.bash" ]; then
        . "$BREW_PREFIX/etc/bash_completion.d/git-completion.bash"
    fi
    if [ -f "$BREW_PREFIX/etc/bash_completion.d/git-prompt.sh" ]; then
        . "$BREW_PREFIX/etc/bash_completion.d/git-prompt.sh"
    fi
# Check for local Homebrew installation
elif [ -d "$HOME/.local/homebrew" ]; then
    if [ -f "$HOME/.local/homebrew/etc/bash_completion.d/git-completion.bash" ]; then
        . "$HOME/.local/homebrew/etc/bash_completion.d/git-completion.bash"
    fi
    if [ -f "$HOME/.local/homebrew/etc/bash_completion.d/git-prompt.sh" ]; then
        . "$HOME/.local/homebrew/etc/bash_completion.d/git-prompt.sh"
    fi
# Try local files
else
    if [ -f "$HOME/.git-completion.bash" ]; then
        . "$HOME/.git-completion.bash"
    fi
    if [ -f "$HOME/.git-prompt.sh" ]; then
        . "$HOME/.git-prompt.sh"
    fi
fi

# Set prompt with git information if available
[ -f ~/.ps1-output-cache ] || touch ~/.ps1-output-cache

if declare -f __git_ps1 > /dev/null; then
    PS1='\[\033[01;30m\]$(cat ~/.ps1-output-cache)\[\033[00m\]\n\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\] \w\[\033[00m\]$(__git_ps1 " (%s)") $ '
else
    PS1='\[\033[01;30m\]$(cat ~/.ps1-output-cache)\[\033[00m\]\n\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\] \w\[\033[00m\] $ '
fi

# PS1 helper if available
if [ -f "${HOME}/bin/ps1-helper" ]; then
    PROMPT_COMMAND="~/bin/ps1-helper"
fi

# Environment variables
export EDITOR=vim
export BASH_SILENCE_DEPRECATION_WARNING=1

# Load additional configuration files
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi
if [ -f ~/.sh_aliases_local ]; then
    . ~/.sh_aliases_local
fi
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

# GitHub Copilot CLI setup
command -v github-copilot-cli >/dev/null 2>&1 && \
    eval "$(github-copilot-cli alias -- "$0")"

# Google Cloud SDK
command -v brew >/dev/null 2>&1 && source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"

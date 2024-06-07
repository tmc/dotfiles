# ~/.bashrc: executed by bash(1) for non-login shells.
case $- in
*i*) ;;
*) return ;;
esac
if [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

command -v brew >/dev/null 2>&1 && source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=200000000
PROMPT_COMMAND="~/bin/ps1-helper"
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -n"

PS1='\[\033[1;31m\]$(prompt_status)\[\033[01;34m\]${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\[\033[00m\]\n\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $ '
PS1='\[\033[1;31m\]$(prompt_status)\[\033[01;34m\]${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\[\033[00m\]\n\[\033[01;32m\]\u@$(hostname)\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $ '
PS1='$(prompt_status)\[\033[01;30m\]$(cat ~/.ps1-output-cache)\[\033[00m\]\n\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '
PS1='\[\033[01;30m\]$(cat ~/.ps1-output-cache)\[\033[00m\]\n\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '

if ! declare -f __git_ps1 > /dev/null; then
    PS1='\[\033[01;30m\]$(cat ~/.ps1-output-cache)\[\033[00m\]\n\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $ '
fi

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $ '

export BASH_SILENCE_DEPRECATION_WARNING=1

export EDITOR=vim
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH=$HOME/bin:$PATH
#source $(brew --prefix)/etc/bash_completion
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# if brew exists and the git-prompt.sh file exists, source it
if [ command -v brew >/dev/null 2>&1 ]; then
    git_prompt_file="$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
    if [ -f "$git_prompt_file" ]; then
        source "$git_prompt_file"
    fi
fi

# if github-copilot-cli exists, source the alias:
command -v github-copilot-cli >/dev/null 2>&1 && \
    eval "$(github-copilot-cli alias -- "$0")"


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
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/opt/homebrew/lib/ruby/gems/3.3.0/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


# ~/.bashrc: executed by bash(1) for non-login shells.
case $- in
*i*) ;;
*) return ;;
esac
export PATH=/opt/homebrew/bin/:$PATH

source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"
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

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $ '

if [ -f ~/.bash_aliases ]; then
       . ~/.bash_aliases
fi
if [ -f ~/.sh_aliases ]; then
       . ~/.sh_aliases
fi
if [ -f ~/.sh_aliases_local ]; then
       . ~/.sh_aliases_local
fi


export BASH_SILENCE_DEPRECATION_WARNING=1

export EDITOR=vim
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH=$HOME/bin:/usr/local/bin:$PATH
source $(brew --prefix)/etc/bash_completion
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
source "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
eval "$(github-copilot-cli alias -- "$0")"


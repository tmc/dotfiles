# ~/.bashrc: executed by bash(1) for non-login shells.
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
case $- in
*i*) ;;
*) return ;;
esac

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

# necessary early as ps1-helper may call gcloud
export CLOUDSDK_PYTHON=python2.7
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"

prompt_status() {
    [ $? = 0 ] && return
    echo -n "${?} "
}
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $ '
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]user@computer\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $ '
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;30m\]kube:$(kubectl config current-context)\[\033[00m\] \[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;30m\]kube:$(kubectl config current-context)\n\[\033[00m\]\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;30m\]kube:$(kubectl config current-context) gcloud:$(gcloud config get-value project 2> /dev/null)\n\[\033[00m\]\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;30m\]$(ps1-helper &)\n\[\033[00m\]\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '

# PS1='\[\033[1;31m\]$(prompt_status)\[\033[01;34m\]${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\[\033[00m\]\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '
PS1='\[\033[1;31m\]$(prompt_status)\[\033[01;34m\]${debian_chroot:+($debian_chroot)}\[\033[01;30m\]$(cat ~/.ps1-output-cache)\[\033[00m\]\n\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)") $ '
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


if ! shopt -oq posix; then
	if [ -f /usr/local/etc/bash_completion ]; then
		. /usr/local/etc/bash_completion
	fi
fi

export EDITOR=vim
export PATH=$HOME/bin:/usr/local/bin:$PATH
#export GOPATH=$HOME/go
#export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/go/bin/darwin_arm64:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=/home/user/.config/yarn/global/node_modules/.bin:$PATH
export PATH="/Users/tmc/.deno/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export GPG_TTY=$(tty)

# virta
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$(which python3)

#export PATH=/usr/local/n/versions/node/8.9.4/bin:$PATH

#set -o vi
#bind -m vi-command ".":insert-last-argument
#bind -m vi-insert "\C-l.":clear-screen
#bind -m vi-insert "\C-a.":beginning-of-line
#bind -m vi-insert "\C-e.":end-of-line
#bind -m vi-insert "\C-w.":backward-kill-word


## The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/travis/google-cloud-sdk/path.bash.inc' ]; then source '/Users/travis/google-cloud-sdk/path.bash.inc'; fi

## The next line enables shell command completion for gcloud.
#if [ -f '/Users/travis/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/travis/google-cloud-sdk/completion.bash.inc'; fi
#eval "$(jira --completion-script-bash)"
#source <(kubectl completion bash)


#nvm:
alias loadnvm='source /usr/local/opt/nvm/nvm.sh'
export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# eval "$(jira --completion-script-bash)"

# . <(bqconn completion)
# function uriencode { jq -nr --arg v "$1" '$v|@uri'; }
# eval "$(jira --completion-script-bash)"
# Add the following to your shell init to set up gpg-agent automatically for every shell
# if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#     source ~/.gnupg/.gpg-agent-info
#     export GPG_AGENT_INFO
# else
#     eval $(gpg-agent --daemon)
# fi

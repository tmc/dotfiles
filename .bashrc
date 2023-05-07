# ~/.bashrc: executed by bash(1) for non-login shells.
case $- in
*i*) ;;
*) return ;;
esac

prompt_status() {
    [ $? = 0 ] && return
    echo -n "${?} "
}

PS1='\[\033[1;31m\]$(prompt_status)\[\033[01;34m\]${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\[\033[00m\]\n\[\033[01;32m\]\u@vmbp\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $ '
export BASH_SILENCE_DEPRECATION_WARNING=1
export OPENAI_API_KEY=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

export EDITOR=vim
export PATH=$HOME/bin:/usr/local/bin:$PATH
#export GOPATH=$HOME/go
#export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/home/user/.config/yarn/global/node_modules/.bin:$PATH
export PATH="/Users/tmc/.deno/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
#export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

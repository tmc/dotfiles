# tmc's .zshrc
export EDITOR=vim
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi
if [ -f ~/.sh_aliases_local ]; then
	. ~/.sh_aliases_local
fi

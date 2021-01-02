# tmc's .zshrc
export PS1='%n@%m %~$ '
export EDITOR=vim
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/go/bin/darwin_arm64:$PATH
export PATH=$HOME/.cargo/bin:$PATH
autoload -U edit-command-line


HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi
if [ -f ~/.sh_aliases_local ]; then
	. ~/.sh_aliases_local
fi
if [ -f ~/.zshrc_local ]; then
	. ~/.zshrc_local
fi

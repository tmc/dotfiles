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


# JINA_CLI_BEGIN

## autocomplete
if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jina jina

_jina() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jina commands)"
  else
    completions="$(jina completions ${words[2,-2]})"
  fi

  reply=(${(ps:
:)completions})
}

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# JINA_CLI_END



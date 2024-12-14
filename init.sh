#!/bin/bash
# usage: curl https://raw.githubusercontent.com/tmc/dotfiles/master/init.sh | sh -x
set -eu
test -f .bashrc && cp .bashrc .bashrc-$(date +%s)
test -f .vimrc && cp .vimrc .vimrc-$(date +%s)
test -f .gitconfig && cp .gitconfig .gitconfig-$(date +%s)

if command -v git >/dev/null 2>&1; then
    # Git exists, clone repo and create symlinks
    mkdir -p ~/go/src/github.com/tmc
    git clone https://github.com/tmc/dotfiles ~/go/src/github.com/tmc/dotfiles
    ln -sf ~/go/src/github.com/tmc/dotfiles/.bashrc ~/.bashrc
    ln -sf ~/go/src/github.com/tmc/dotfiles/.vimrc ~/.vimrc 
    ln -sf ~/go/src/github.com/tmc/dotfiles/.gitconfig ~/.gitconfig
    ln -sf ~/go/src/github.com/tmc/dotfiles/.sh_aliaes ~/.sh_aliases
else
    # No git, download files directly
    curl -o ~/.bashrc https://raw.githubusercontent.com/tmc/dotfiles/master/.bashrc
    curl -o ~/.vimrc https://raw.githubusercontent.com/tmc/dotfiles/master/.vimrc
    curl -o ~/.gitconfig https://raw.githubusercontent.com/tmc/dotfiles/master/.gitconfig
    curl -o ~/.sh_aliases https://raw.githubusercontent.com/tmc/dotfiles/master/.sh_aliases
fi

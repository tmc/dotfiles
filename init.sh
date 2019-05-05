#!/bin/bash
set -eu
# curl https://raw.githubusercontent.com/tmc/dotfiles/master/init.sh | sh -x
test -f .bashrc && cp .bashrc .bashrc-$(date +%s)
test -f .vimrc && cp .vimrc .vimrc-$(date +%s)
test -f .gitconfig && cp .gitconfig .gitconfig-$(date +%s)
curl -o .bashrc https://raw.githubusercontent.com/tmc/dotfiles/master/.bashrc
curl -o .vimrc https://raw.githubusercontent.com/tmc/dotfiles/master/.vimrc
curl -o .gitconfig https://raw.githubusercontent.com/tmc/dotfiles/master/.gitconfig

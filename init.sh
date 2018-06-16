#!/bin/bash
set -euo pipefail
# curl https://raw.githubusercontent.com/tmc/dotfiles/master/init.sh | bash -x
test -f .bashrc && cp .bashrc .bashrc-bak
test -f .vimrc && cp .vimrc .vimrc-bak
curl -o .bashrc https://raw.githubusercontent.com/tmc/dotfiles/master/.bashrc
curl -o .vimrc https://raw.githubusercontent.com/tmc/dotfiles/master/.vimrc

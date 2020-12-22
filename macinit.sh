#!/bin/bash
# macinit - initialize a new mac machine.
set -eu
GITROOTP="${HOME}/go/src/github.com/${USER}"
GITROOT="${GITROOTP}/dotfiles"
FILES=(.bashrc .zshrc .vimrc .gitconfig .iterm2 .sh_aliases)
file -d "${GITROOTP}" || mkdir -p "${GITROOTP}"
file -d "${GITROOT}" || (cd "${GITROOTP}"; git clone https://github.com/tmc/dotfiles.git)
cd "${HOME}"
for f in "${FILES[@]}"; do 
    test -L "${f}" && mv "${f}" "${f}-$(date +%s))"
    ln -s "${GITROOT}/${f}" .
done

# Ensure brew is installed.
command -v brew > /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install homebrew bundle.
cd "${GITROOT}"
brew bundle install
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

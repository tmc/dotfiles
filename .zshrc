# tmc's .zshrc
export PS1='%n@%m %~$ '
export EDITOR=vim
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/go/bin/darwin_arm64:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

if [ -f "$HOME/.sh_aliases" ]; then
    . "$HOME/.sh_aliases"
fi
if [ -f "$HOME/.sh_aliases_local" ]; then
    . "$HOME/.sh_aliases_local"
fi
if [ -f "$HOME/.zshrc_local" ]; then
    . "$HOME/.zshrc_local"
fi

# Enable Git completion in Zsh
GIT_COMPLETION_FILE="$HOME/.git-completion.bash"
GIT_PROMPT_FILE="$HOME/.git-prompt.sh"

# Check if brew is available (in PATH or as an alias) and use its Git scripts
if command -v brew >/dev/null 2>&1 || alias brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix 2>/dev/null || echo "/usr/local")
    if [ -f "$BREW_PREFIX/etc/bash_completion.d/git-completion.bash" ]; then
        autoload -Uz compinit && compinit
        autoload -Uz bashcompinit && bashcompinit
        . "$BREW_PREFIX/etc/bash_completion.d/git-completion.bash"
    fi
    if [ -f "$BREW_PREFIX/etc/bash_completion.d/git-prompt.sh" ]; then
        . "$BREW_PREFIX/etc/bash_completion.d/git-prompt.sh"
    fi
# Check for local Homebrew installation at ~/.local/homebrew/
elif [ -d "$HOME/.local/homebrew" ]; then
    if [ -f "$HOME/.local/homebrew/etc/bash_completion.d/git-completion.bash" ]; then
        autoload -Uz compinit && compinit
        autoload -Uz bashcompinit && bashcompinit
        . "$HOME/.local/homebrew/etc/bash_completion.d/git-completion.bash"
    fi
    if [ -f "$HOME/.local/homebrew/etc/bash_completion.d/git-prompt.sh" ]; then
        . "$HOME/.local/homebrew/etc/bash_completion.d/git-prompt.sh"
    fi
# Download Git completion and prompt scripts if not present and no brew/local found
else
    if [ ! -f "$GIT_COMPLETION_FILE" ]; then
        curl -sL "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" -o "$GIT_COMPLETION_FILE"
    fi
    if [ ! -f "$GIT_PROMPT_FILE" ]; then
        curl -sL "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh" -o "$GIT_PROMPT_FILE"
    fi
    autoload -Uz compinit && compinit
    autoload -Uz bashcompinit && bashcompinit
    [ -f "$GIT_COMPLETION_FILE" ] && . "$GIT_COMPLETION_FILE"
    [ -f "$GIT_PROMPT_FILE" ] && . "$GIT_PROMPT_FILE"
fi


#export ZDOTDIR="${HOME}/.config/zsh"

# Set TERM for Kitty
export TERM=xterm-256color

# If you're inside tmux, set TERM for it
if [ -n "$TMUX" ]; then
    export TERM=screen-256color
fi

export MANPAGER='nvim +Man!'
export MANWIDTH=99
#!/usr/bin/env bash

export EDITOR="nvim"
export SUDO_EDITOR="nvim"

# customized path
export PATH="$PATH:$HOME/.config/zsh/bin"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$PATH:/opt/homebrew/opt/ccache/libexec"
export PATH="$PATH:/Users/mac/projects/logLLM/model/llama.cpp/build/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH
export PATH=$HOME/.gem/bin:$PATH

export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

export CARGOPATH="$HOME/.cargo"
# export PATH="$PATH:$CARGOPATH/bin"
# . "$HOME/.cargo/env"

export zsh_bin="$ZDOTDIR/bin"
# export INPUTRC=$ZDOTDIR/inputrc

export LESS='--mouse --wheel-lines=5'
export PAGER='less -R'
export MANPAGER='nvim +Man!'
#export MANWIDTH=99

# only for macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"``

# brew
export HOMEBREW_NO_AUTO_UPDATE=1
export LC_CTYPE=en_US.UTF-8
export VIRTUAL_ENV_DISABLE_PROMPT=

# YABAI
export YABAI_SWAP_NEXT=1
export YABAI_AUTO_BALANCE="on"
export PATH="/Library/TeX/texbin:$PATH"

export PIPX_HOME="$HOME/.local/pipx"

export JAVA_HOME=/opt/homebrew/opt/openjdk

export PATH="$PATH":"$HOME/.pub-cache/bin"

export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"

export FLUTTER_ROOT="$(asdf where flutter)"

# Added by `rbenv init` on Fri Jun  6 09:22:27 HKT 2025
eval "$(rbenv init - --no-rehash zsh)"

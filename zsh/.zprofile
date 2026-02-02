#export ZDOTDIR="${HOME}/.config/zsh"

export MANPAGER='nvim +Man!'
export MANWIDTH=99

export EDITOR="nvim"
export SUDO_EDITOR="nvim"

export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

export CARGOPATH="$HOME/.cargo"
# export PATH="$PATH:$CARGOPATH/bin"
# . "$HOME/.cargo/env"

export zsh_bin="$ZDOTDIR/bin"
# export INPUTRC=$ZDOTDIR/inputrc

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

export PIPX_HOME="$HOME/.local/pipx"

export JAVA_HOME=/opt/homebrew/opt/openjdk

# mac only
if [[ "$(uname -s)" == "Darwin" ]]; then
  # export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"
  unset DOCKER_HOST
  docker context use orbstack &> /dev/null
fi


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

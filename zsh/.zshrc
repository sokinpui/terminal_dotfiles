load-mod(){
  # load with path given
  if [[ -f $1 ]]; then
    source $1
  fi
}


# module config
# ==============================================================

if [[ "$OSTYPE" == "darwin"* ]]; then
  load-mod $HOME/.config/zsh/mod/brew
fi

# load-mod $HOME/.config/zsh/mod/ruby
# load-mod $HOME/.config/zsh/mod/conda
# load-mod $HOME/.luaver/luaver
load-mod $HOME/.config/zsh/mod/fzf
load-mod $HOME/.config/zsh/mod/fzf-key-binds.zsh
load-mod $HOME/.config/zsh/mod/lf
load-mod $HOME/.config/zsh/mod/delta
# load-mod $HOME/.config/zsh/mod/fzf-tab/fzf-tab.plugin.zsh

load-mod $HOME/.api_key
load-mod $HOME/.config/zsh/mod/completion
load-mod $HOME/.config/zsh/mod/aliasrc
load-mod $HOME/.config/zsh/mod/keymaps
load-mod $HOME/.config/zsh/mod/shortcuts
load-mod $HOME/.config/zsh/mod/git-prompt.sh
load-mod $HOME/.config/zsh/mod/vim_mode
load-mod $HOME/.config/zsh/mod/appearance
load-mod $HOME/.config/zsh/mod/flutter
load-mod $HOME/.config/zsh/mod/pyenv
load-mod $HOME/.config/zsh/mod/yazi

# ===============================================================


export ZSHZ_CASE=smart


# History
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# smarter cd like z
eval "$(zoxide init zsh)"

export ES_JAVA_HOME=/opt/homebrew/Cellar/openjdk/21.0.2/libexec/openjdk.jdk/Contents/Home


# only for macOs
if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! pgrep -u $USER skhd >/dev/null 2>&1; then
    skhd --start-service
  fi
  defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
fi

eval "$(direnv hook zsh)"

set -o ignoreeof


export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


load-mod $HOME/.localconfig

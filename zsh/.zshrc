# applicaiton specific settings
# ==============================================================
[ -f $HOME/.config/zsh/mod/brew ] && source $HOME/.config/zsh/mod/brew
[ -f $HOME/.config/zsh/mod/aliasrc ] && source $HOME/.config/zsh/mod/aliasrc
[ -f $HOME/.config/zsh/mod/keymaps ] && source $HOME/.config/zsh/mod/keymaps
[ -f $HOME/.config/zsh/mod/shortcuts ] && source $HOME/.config/zsh/mod/shortcuts
[ -f $HOME/.config/zsh/mod/git-prompt.sh ] && source /$HOME/.config/zsh/mod/git-prompt.sh
[ -f $HOME/.config/zsh/mod/vim_mode ] && source $HOME/.config/zsh/mod/vim_mode
[ -f $HOME/.config/zsh/mod/appearance ] && source $HOME/.config/zsh/mod/appearance
[ -f $HOME/.config/zsh/mod/completion ] && source $HOME/.config/zsh/mod/completion
# [ -f $HOME/.config/zsh/mod/ruby ] && source $HOME/.config/zsh/mod/ruby
[ -f $HOME/.api_key ] && source $HOME/.api_key
# [ -f $HOME/.config/zsh/mod/conda ] && source $HOME/.config/zsh/mod/conda
#[ -s ~/.luaver/luaver ] && . ~/.luaver/luaver
[ -f ~/.config/zsh/mod/fzf ] && source ~/.config/zsh/mod/fzf
[ -f ~/.config/zsh/mod/fzf-key-binds.zsh ] && source ~/.config/zsh/mod/fzf-key-binds.zsh
# [ -f ~/.config/zsh/mod/lf ] && source ~/.config/zsh/mod/lf
[ -f ~/.config/zsh/mod/yazi ] && source ~/.config/zsh/mod/yazi
[ -f ~/.localconfig ] && source ~/.localconfig

# ===============================================================


export ZSHZ_CASE=smart

fpath=(
    ~/.config/zsh/autoload
    ~/.zsh $fpath)
autoload -Uz ~/.config/zsh/autoload/*(.:t)

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

if ! pgrep -u $USER skhd >/dev/null 2>&1; then
  skhd --start-service
fi

defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

eval "$(direnv hook zsh)"

autoload -U compinit && compinit

set -o ignoreeof

export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH=$HOME/development/flutter/bin:$PATH

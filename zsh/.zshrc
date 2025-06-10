[ -f $HOME/.config/zsh/brew ] && source $HOME/.config/zsh/brew
[ -f $HOME/.config/zsh/aliasrc ] && source $HOME/.config/zsh/aliasrc
[ -f $HOME/.config/zsh/keymaps ] && source $HOME/.config/zsh/keymaps
[ -f $HOME/.config/zsh/shortcuts ] && source $HOME/.config/zsh/shortcuts
[ -f $HOME/.config/zsh/git-prompt.sh ] && source /$HOME/.config/zsh/git-prompt.sh
[ -f $HOME/.config/zsh/vim_mode ] && source $HOME/.config/zsh/vim_mode
[ -f $HOME/.config/zsh/appearance ] && source $HOME/.config/zsh/appearance
[ -f $HOME/.config/zsh/completion ] && source $HOME/.config/zsh/completion
# [ -f $HOME/.config/zsh/ruby ] && source $HOME/.config/zsh/ruby
[ -f $HOME/.api_key ] && source $HOME/.api_key

# [ -f $HOME/.config/zsh/conda ] && source $HOME/.config/zsh/conda

# lua version switcher
#[ -s ~/.luaver/luaver ] && . ~/.luaver/luaver

#fzf
# source <(fzf --zsh)
[ -f ~/.config/zsh/fzf ] && source ~/.config/zsh/fzf
[ -f ~/.config/zsh/fzf-key-binds.zsh ] && source ~/.config/zsh/fzf-key-binds.zsh

# lf
[ -f ~/.config/zsh/lf ] && source ~/.config/zsh/lf


export ZSHZ_CASE=smart

fpath=(
    ~/.config/zsh/autoload
    ~/.zsh $fpath)
autoload -Uz ~/.config/zsh/autoload/*(.:t)

# History
HISTSIZE=1000000
SAVEHIST=1000000
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


# function remove_skhd_lock_file_on_end() {
#   local process_name="$(ps -p $SKHD_PID | tail -n 1 | awk '{print $4}')"
#
#   while [[ $process_name == "skhd" ]]; do
#     local process_name="$(ps -p $SKHD_PID | tail -n 1 | awk '{print $4}')"
#     sleep 1
#   done
#
#   rm /tmp/skhd.lock
#   rm /tmp/skhd_$(whoami).pid
# }
#
# if [ -z "$SSH_CONNECTION" ]; then
#   if [ ! -f /tmp/skhd.lock ]; then
#     echo "skhd is not running. Starting skhd..."
#     echo "skhd is running" > /tmp/skhd.lock
#     skhd &!
#     SKHD_PID=$!
#
#     remove_skhd_lock_file_on_end &
#   fi
# else
#   echo "skhd will not run in an SSH session."
# fi

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/mac/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mac/tmp/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/mac/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mac/tmp/google-cloud-sdk/completion.zsh.inc'; fi

defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

eval "$(direnv hook zsh)"

autoload -U compinit && compinit

set -o ignoreeof

export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH=$HOME/development/flutter/bin:$PATH

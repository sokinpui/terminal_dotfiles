export TERM=xterm-256color

# If you're inside tmux, set TERM for it
if [ -n "$TMUX" ]; then
    export TERM=screen-256color
fi

export PATH="$PATH:$HOME/.config/zsh/bin"
export PATH=$PATH:$GOPATH/bin
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$PATH:/opt/homebrew/opt/ccache/libexec"
export PATH="$PATH:/Users/mac/projects/logLLM/model/llama.cpp/build/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin:$PATH"
export PATH=/Library/TeX/texbin:$PATH
export PATH=$HOME/.gem/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="/Library/TeX/texbin:$PATH"
export PATH=$HOME/development/flutter/bin:$PATH

export GOPATH=$HOME/go

export LESS='--mouse --wheel-lines=5'
export PAGER='less -R'
export MANPAGER='nvim +Man!'


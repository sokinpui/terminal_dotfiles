#!/bin/bash

sudo apt install -y curl wget git build-essential python3 python3-pip zsh tmux neovim fd-find fzf zoxide ripgrep direnv pipx

ln -s $(which fdfind) ~/.local/bin/fd

pipx install trash-cli

sudo apt remove -y fzf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

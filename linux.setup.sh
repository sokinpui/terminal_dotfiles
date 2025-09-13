#!/bin/bash

sudo apt install -y curl wget git build-essential python3 python3-pip zsh tmux neovim fd-find fzf zoxide ripgrep direnv

ln -s $(which fdfind) ~/.local/bin/fd

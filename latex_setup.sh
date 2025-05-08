#!/bin/bash

brew update

brew install --cask mactex
brew install skim

cd /tmp || exit
wget https://raw.githubusercontent.com/emanuelenardi/latex-packages/refs/heads/master/tikz-uml/tikz-uml.sty

mkdir -p ~/Library/texmf/tex/latex/tikz-uml/

mv /tmp/tikz-uml.sty ~/Library/texmf/tex/latex/tikz-uml/

texhash ~/Library/texmf/tex/latex/tikz-uml/

#!/usr/bin/env zsh

brew update
brew upgrade
brew install fx bat fd ripgrep xh eza neovim tmux
[[ $MACOS_SERVER != "1" ]] && echo "brew install MisterTea/et/et 1password-cli"
brew cleanup

#!/usr/bin/env zsh

brew update
brew upgrade
brew install fx yq bat fd ripgrep xh eza neovim tmux unar
[[ $MACOS_CLIENT == "1" ]] && brew install MisterTea/et/et 1password-cli
brew cleanup

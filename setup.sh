#!/bin/env zsh

echo "============================================================"
echo "| This script assumes that requirements are all installed! |"
echo "============================================================"

function link_dotfile() {
  # back up $filepath, and link it to $dot_filename
  readonly filepath=${1:?"The filepath must be specified."}
  readonly dot_filename=${2:?"The dot_filename must be specified."}

  if [[ -f $filepath ]]; then
    if [[ -L $filepath ]]; then
      echo "$filepath is already a symlink, skipping linking it to $PWD/$dot_filename"
    else
      mv $filepath{,.bak}
      ln -s $PWD/$dot_filename $filepath
      echo "$filepath is now a symlink to $PWD/$dot_filename"
    fi
  fi
}


link_dotfile $HOME/.zshrc zshrc
link_dotfile $HOME/.tmux.conf tmux.conf
link_dotfile $HOME/.vimrc vimrc
mkdir -p $HOME/.config/nvim
link_dotfile $HOME/.config/nvim/init.vim init.vim
link_dotfile $HOME/.config/nvim/coc-settings.json coc-settings.json

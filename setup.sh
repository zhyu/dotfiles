#!/usr/bin/env zsh

echo "============================================================"
echo "| This script assumes that requirements are all installed! |"
echo "============================================================"

function link_dotfile() {
  # back up $filepath, and link it to $dot_filename
  readonly filepath=${1:?"The filepath must be specified."}
  readonly dot_filename=${2:?"The dot_filename must be specified."}

  if [[ -f $filepath || -d $filepath ]]; then
    if [[ -L $filepath ]]; then
      echo "$filepath is already a symlink, skipping linking it to $PWD/$dot_filename"
      return
    else
      mv $filepath{,.bak}
    fi
  fi

  mkdir -p $(dirname $filepath)
  ln -s $PWD/$dot_filename $filepath
  echo "$filepath is now a symlink to $PWD/$dot_filename"
}


link_dotfile $HOME/.zshrc zshrc
link_dotfile $HOME/.tmux.conf tmux.conf
link_dotfile $HOME/.config/nvim nvim

#!/usr/bin/env zsh

echo "============================================================"
echo "| This script assumes that requirements are all installed! |"
echo "============================================================"

echo "=========================="
echo "| Installing packages... |"
echo "=========================="

if type brew &> /dev/null; then
  ./scripts/install_pkgs_homebrew.sh
elif type apt &> /dev/null; then
  ./scripts/install_pkgs_apt.sh
else
  echo "No supported package manager {homebrew, apt} found. Exiting..."
  exit 1;
fi

echo "======================="
echo "| Linking dotfiles... |"
echo "======================="

function link_dotfile() {
  # back up $filepath, and link it to $dot_filepath
  readonly filepath=${1:?"The filepath must be specified."}
  readonly dot_filepath=${2:?"The dot_filepath must be specified."}

  if [[ -f $filepath || -d $filepath ]]; then
    if [[ -L $filepath ]]; then
      echo "$filepath is already a symlink, skipping linking it to $PWD/$dot_filepath"
      return
    else
      mv $filepath{,.bak}
    fi
  fi

  mkdir -p $(dirname $filepath)
  ln -s $PWD/$dot_filepath $filepath
  echo "$filepath is now a symlink to $PWD/$dot_filepath"
}

# zsh
link_dotfile $HOME/.zshrc zsh/zshrc
link_dotfile $HOME/.oh-my-zsh zsh/ohmyzsh
link_dotfile $HOME/.p10k.zsh zsh/p10k.zsh
# tmux
link_dotfile $HOME/.tmux.conf tmux/tmux.conf
link_dotfile $HOME/.tmux/plugins/tpm tmux/tpm
# nvim
link_dotfile $HOME/.config/nvim nvim
# fzf
link_dotfile $HOME/.fzf fzf
$HOME/.fzf/install --bin # download the binary only

echo "=============================="
echo "| Updating configurations... |"
echo "=============================="

# store the git credential (for the access key)
git config --global credential.helper store

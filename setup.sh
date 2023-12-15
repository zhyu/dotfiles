#!/usr/bin/env zsh

echo "============================================================"
echo "| This script assumes that requirements are all installed! |"
echo "============================================================"

echo "=========================="
echo "| Installing packages... |"
echo "=========================="

[[ $(uname) == "Darwin" ]] && ./scripts/install_pkgs_macos.sh
[[ $(uname) == "Linux" ]] && ./scripts/install_pkgs_ubuntu.sh

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

function configure_git_remote() {
  readonly remote_name=${1:?"The remote_name must be specified."}
  readonly remote_url=${2:?"The remote_url must be specified."}

  git remote | rg "^${remote_name}$" > /dev/null && git remote remove $remote_name
  git remote add $remote_name $remote_url
}

configure_git_remote fzf https://github.com/junegunn/fzf.git
configure_git_remote tpm https://github.com/tmux-plugins/tpm.git
configure_git_remote ohmyzsh https://github.com/ohmyzsh/ohmyzsh.git
configure_git_remote fasd https://github.com/whjvenyl/fasd.git
configure_git_remote fast-syntax-highlighting https://github.com/zdharma-continuum/fast-syntax-highlighting.git
configure_git_remote fzf-tab https://github.com/Aloxaf/fzf-tab.git
configure_git_remote zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
configure_git_remote powerlevel10k https://github.com/romkatv/powerlevel10k.git

# store the git credential (for the access key)
git config --global credential.helper store

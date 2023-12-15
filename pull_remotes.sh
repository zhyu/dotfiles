#!/usr/bin/env zsh

echo "============================================================"
echo "| This script assumes that requirements are all installed! |"
echo "============================================================"

echo "=============================="
echo "| Updating configurations... |"
echo "=============================="

function pull_remote() {
  readonly remote_url=${1:?"The remote_url must be specified."}
  readonly subtree_dir=${2:?"The subtree_dir must be specified."}
  readonly remote_ref=${3:-"master"}

  # parse remote name from remote url: last part of url without .git
  local remote_name=$(echo $remote_url | awk -F/ '{print $NF}' | sed 's/\.git$//')

  git remote | rg "^${remote_name}$" > /dev/null && git remote remove $remote_name
  git remote add $remote_name $remote_url

  git fetch $remote_name $remote_ref

  git subtree pull --prefix=$subtree_dir $remote_name $remote_ref --squash
}

pull_remote https://github.com/junegunn/fzf.git fzf
pull_remote https://github.com/tmux-plugins/tpm.git tmux/tpm
pull_remote https://github.com/ohmyzsh/ohmyzsh.git zsh/ohmyzsh
pull_remote https://github.com/whjvenyl/fasd.git zsh/ohmyzsh/custom/plugins/fasd
pull_remote https://github.com/zdharma-continuum/fast-syntax-highlighting.git zsh/ohmyzsh/custom/plugins/fast-syntax-highlighting
pull_remote https://github.com/Aloxaf/fzf-tab.git zsh/ohmyzsh/custom/plugins/fzf-tab
pull_remote https://github.com/zsh-users/zsh-autosuggestions.git zsh/ohmyzsh/custom/plugins/zsh-autosuggestions
pull_remote https://github.com/romkatv/powerlevel10k.git zsh/ohmyzsh/custom/themes/powerlevel10k

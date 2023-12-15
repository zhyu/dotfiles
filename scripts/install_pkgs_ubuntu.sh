#!/usr/bin/env zsh

function download_github_asset() {
  readonly repo_owner=${1:?"The repository owner must be specified."}
  readonly repo_name=${2:?"The repository name must be specified."}
  readonly file_name_regex=${3:?"The file name regex must be specified."}
  readonly output_file_name=${4:?"The output file name must be specified."}

  curl -L -o ${output_file_name} $(curl -s https://api.github.com/repos/${repo_owner}/${repo_name}/releases/latest | fx '.assets[]' ".filter(x => /${file_name_regex}/.test(x.name))" '.[0].browser_download_url')
}

function setup_executable_from_github () {
  readonly repo_owner=${1:?"The repository owner must be specified."}
  readonly repo_name=${2:?"The repository name must be specified."}
  readonly file_name_regex=${3:?"The file name regex must be specified."}
  readonly executable_name=${4:?"The executable name must be specified."}

  mkdir -p ~/bin && pushd $_

  rm -f ${executable_name}
  sudo rm -f /usr/local/bin/${executable_name}

  download_github_asset ${repo_owner} ${repo_name} ${file_name_regex} ${executable_name} && chmod +x ${executable_name} && sudo ln -s ~/bin/${executable_name} /usr/local/bin/${executable_name}
}

# install basic dependencies
sudo apt install -y software-properties-common

curl https://fx.wtf/install.sh | sudo sh

# add ppa
sudo add-apt-repository -y ppa:jgmath2000/et
# rust tools repo: https://apt.cli.rs/
curl -fsSL https://apt.cli.rs/pubkey.asc | sudo tee /usr/share/keyrings/rust-tools.asc
curl -fsSL https://apt.cli.rs/rust-tools.list | sudo tee /etc/apt/sources.list.d/rust-tools.list
# eza repo
curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo tee /usr/share/keyrings/gierens.asc
echo "deb [signed-by=/usr/share/keyrings/gierens.asc] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list

# apt install
sudo apt update
# bat-musl and fd-musl are statically-linked binaries
sudo apt install -y et bat-musl fd-musl ripgrep xh eza
sudo apt upgrade -y
sudo apt autoremove -y

# app images and other binaries
setup_executable_from_github neovim neovim 'nvim.appimage$' nvim
setup_executable_from_github nelsonenzo tmux-appimage 'tmux.appimage$' tmux
setup_executable_from_github mikefarah yq 'yq_linux_amd64$' yq

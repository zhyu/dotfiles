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

cat remote_repos.json | fx  '.map(x => [x.repo, x.gitSubtreeDir, x.ref].join(" "))' '.join("\n")' | while read line; do
  pull_remote $(echo $line | awk '{print $1, $2, $3}')
done

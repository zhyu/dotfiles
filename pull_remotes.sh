#!/usr/bin/env zsh

echo "============================================================"
echo "| This script assumes that requirements are all installed! |"
echo "============================================================"

echo "==========================="
echo "| Pulling remote repos... |"
echo "==========================="

function pull_remote() {
  readonly json_conf=${1:?"The json_conf must be specified."}
  IFS="|" read remote_url subtree_dir remote_ref callback <<< $(echo $json_conf | fx '[x.repo, x.gitSubtreeDir, x.ref || "master", x.callback || ""].join("|")')

  : ${remote_url:?"The repo must be specified in the json_conf."}
  : ${subtree_dir:?"The gitSubtreeDir must be specified in the json_conf."}

  echo "Pulling remote repo: $remote_url into $subtree_dir"

  # parse remote name from remote url: last part of url without .git
  local remote_name=$(echo $remote_url | awk -F/ '{print $NF}' | sed 's/\.git$//')

  git remote | rg "^${remote_name}$" > /dev/null && git remote remove $remote_name
  git remote add $remote_name $remote_url

  # if the $subtree_dir doesn't exist, it means it's a new repo, so we need to add it to git subtree,
  # otherwise we need to pull the changes
  if [ ! -d $subtree_dir ]; then
    git subtree add --prefix=$subtree_dir $remote_name $remote_ref --squash
  else
    git subtree pull --prefix=$subtree_dir $remote_name $remote_ref --squash
  fi

  if [ -n "$callback" ]; then
    echo "Running callback: $callback"
    eval $callback
  fi
  echo "------------------------------------------------------------"
}

fx --yaml remote_repos.yml '.map(x => JSON.stringify(x))' list | while read json_conf; do
  pull_remote $json_conf
done

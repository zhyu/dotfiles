#!/usr/bin/env zsh

echo "============================================================"
echo "| This script assumes that requirements are all installed! |"
echo "============================================================"

echo "==========================="
echo "| Pulling remote repos... |"
echo "==========================="

function pull_remote() {
  readonly json_conf=${1:?"The json_conf must be specified."}

  readonly remote_url=$(echo $json_conf | fx '.repo || ""')
  readonly subtree_dir=$(echo $json_conf | fx '.gitSubtreeDir || ""')
  readonly remote_ref=$(echo $json_conf | fx '.ref || "master"')
  readonly callback=$(echo $json_conf | fx '.callback || ""')

  : ${remote_url:?"The repo must be specified in the json_conf."}
  : ${subtree_dir:?"The gitSubtreeDir must be specified in the json_conf."}

  echo "Pulling remote repo: $remote_url into $subtree_dir"

  # parse remote name from remote url: last part of url without .git
  local remote_name=$(echo $remote_url | awk -F/ '{print $NF}' | sed 's/\.git$//')

  git remote | rg "^${remote_name}$" > /dev/null && git remote remove $remote_name
  git remote add $remote_name $remote_url

  git subtree pull --prefix=$subtree_dir $remote_name $remote_ref --squash

  if [ -n "$callback" ]; then
      echo "Running callback: $callback"
      eval $callback
  fi
  echo "------------------------------------------------------------"
}

yq -oj remote_repos.yml | fx  '.map(x => JSON.stringify(x))' '.join("\n")' | while read line; do
  pull_remote $line
done

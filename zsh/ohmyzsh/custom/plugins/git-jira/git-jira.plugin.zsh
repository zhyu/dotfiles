# List Jira project keys from commit logs
_list_project_keys() {
  git log --pretty=format:%s |
    rg '([A-Z][A-Z_0-9]+)-[0-9]+' -or '$1' |
    sort |
    uniq -c |
    sort -k1,1nr -k2 |
    awk '{print $2}'
  }

# Check out the branch for certain Jira issue
_checkout_branch_for_issue() {
  local branch="jira/${1:u}-$2"
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git checkout "$branch"
  else
    git checkout -b "$branch"
  fi
}

# Define jc function:
# - `jc ISSUE_NUMBER`: check out the branch using the most frequent Jira project key in the commit logs and the given issue number
# - `jc PROJECT_KEY ISSUE_NUMBER`: check out the branch using the given Jira project key and the given issue number
jc() {
  if [[ $# -eq 1 ]] && [[ "$1" =~ ^[0-9]+$ ]]; then
    local project_key=$(_list_project_keys | head -1)
    _checkout_branch_for_issue "$project_key" "$1"
  elif [[ $# -eq 2 ]] && [[ "$1" =~ ^[a-zA-Z][a-zA-Z_0-9]*$ ]] && [[ "$2" =~ ^[0-9]+$ ]]; then
    _checkout_branch_for_issue "$1" "$2"
  else
    echo "Usage: jc [PROJECT_KEY] ISSUE_NUMBER"
  fi
}

# Define jci function:
# - `jci ISSUE_NUMBER`: check out the branch using the Jira project key selected interactively from commit logs and the given issue number
jci() {
  if [[ $# -eq 1 ]] && [[ "$1" =~ ^[0-9]+$ ]]; then
    local project_key=$(_list_project_keys | fzf)
    if [[ -n "$project_key" ]]; then
      _checkout_branch_for_issue "$project_key" "$1"
    fi
  else
    echo "Usage: jci ISSUE_NUMBER"
  fi
}


# Define jcm function:
# - `jcm COMMIT_MESSAGE`: commit using the given commit message with a prefix of Jira issue extracted from the current branch name
jcm() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local issue=$(echo $current_branch | rg 'jira/([A-Z][A-Z_0-9]+-[0-9]+)' -or '$1')
  if [[ -n "$issue" ]]; then
    git commit -m "$issue: $1"
  else
    if [[ $current_branch == nobug/* ]]; then
      git commit -m "NOBUG: $1"
    else
      echo "Cannot extract the Jira issue from the current branch name"
    fi
  fi
}

# Define jcmi function:
# - `jcmi ISSUE_NUMBER COMMIT_MESSAGE`: commit using the given commit message with a prefix of Jira project key selected interactively from commit logs and the given issue number
jcmi() {
  if [[ $# -eq 2 ]] && [[ "$1" =~ ^[0-9]+$ ]]; then
    local project_key=$(_list_project_keys | fzf)
    if [[ -n "$project_key" ]]; then
      git commit -m "$project_key-$1: $2"
    fi
  else
    echo "Usage: jcmi ISSUE_NUMBER COMMIT_MESSAGE"
  fi
}

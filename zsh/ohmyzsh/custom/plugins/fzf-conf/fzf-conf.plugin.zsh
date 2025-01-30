# ~/.fzf should be linked to dotfiles/fzf by the setup.sh script
export PATH="$PATH:$HOME/.fzf/bin"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  fi
fi

# Use fd instead of the default find command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
#
# This function is used when using fzf to complete the path, e.g., `vim **<tab>`
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
#
# This function is used when using fzf to complete the dir, e.g., `cd **<tab>`
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

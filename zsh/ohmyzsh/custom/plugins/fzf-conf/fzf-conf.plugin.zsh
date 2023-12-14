# use fd as backend of fzf, it will respect ignore files like .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# use Ctrl-T to fuzzy search recent accessed files and directories
export FZF_CTRL_T_COMMAND='fasd -Rl'
# Use fd instead of the default find command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

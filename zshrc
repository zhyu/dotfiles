# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode tmux fzf common-aliases fasd git python nvm fzf-tab zsh-autosuggestions fast-syntax-highlighting)
# do not use the user input as the query string when using fzf-tab, since it won't work with fasd word completion, e.g., ,dirname,<TAB>
zstyle ':fzf-tab:*' query-string prefix first

VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
MODE_INDICATOR="%F{cyan}<~~%f"

source $ZSH/oh-my-zsh.sh

# User configuration

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# This is very important for nerdfont glyphs to work inside tmux: https://gitlab.com/gnachman/iterm2/-/issues/10879#note_1433417922
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Server only setup
# symlink ~/.ssh/ssh_auth_sock to $SSH_AUTH_SOCK, then set the env var
# to a fixed location. It will help the tmux/screen
# sessions finding the ssh agent forwarded by differnt ssh sessions.
#
# Creating the symlink in ~/.ssh/rc could do it after the ssh connection
# being established, however, when using Eternal Terminal (et), et will
# set the ssh agent to a different location after ~/.ssh/rc executed,
# which makes ~/.ssh/ssh_auth_sock links to a non-functional location.
# So setting the symlink in ~/.zshrc is easier.
if [[ -n $SSH_CONNECTION ]]; then
    # Prevent recursive link, otherwise when opening tmux, ~/.ssh/ssh_auth_sock
    # will be linked to itself. Since Eternal Terminal won't delete old socket
    # files, we couldn't check whether ~/.ssh/ssh_auth_sock is a socket file
    # ([ ! -S ~/.ssh/ssh_auth_sock ]) to achieve the same goal
    if [ -S "$SSH_AUTH_SOCK" ] && [ ! "$SSH_AUTH_SOCK" -ef ~/.ssh/ssh_auth_sock ]; then
        ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
        export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    fi
fi

# human-readable sizes
alias df='df -h'
# fix LS color on mac OS
alias ls="ls --color=auto -G"

# enable the nice builtin zmv
autoload -U zmv
# noglob: no need to quote wildcards
# -W: auto convert wildcards to the proper format, e.g., no need to use capture groups
alias mmv='noglob zmv -W'

# neovim :)
alias vim='nvim'
alias vimdiff='nvim -d '

# use vim when edit-command-line
export VISUAL=nvim
export EDITOR="${VISUAL}"

# fzf settings
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

# Disable unwanted aliases defined by fasd
unalias j o z v

# fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
# fasd & fzf change directory - open best matched file using `fasd` if given argument, filter output of `fasd` using `fzf` else
v() {
    [ $# -gt 0 ] && fasd -f -e ${EDITOR} "$*" && return
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && ${EDITOR} "${file}" || return 1
}

# source
if [[ -f $HOME/.zshrc.post ]]; then
  source $HOME/.zshrc.post
fi

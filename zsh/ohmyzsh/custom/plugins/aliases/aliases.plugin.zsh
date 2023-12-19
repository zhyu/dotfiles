# eza: better ls
alias ls='eza'
alias l='eza -l'
alias la='eza -la'
alias lt='eza -l --tree'

# human-readable sizes
alias df='df -h'
alias du='du -h'

alias -g H='| head'
alias -g T='| tail'
alias -g G='| rg'
alias -g B="| bat"
alias -g S="| sort"
alias -g U="| uniq"

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# enable the nice builtin zmv
autoload -U zmv
# noglob: no need to quote wildcards
# -W: auto convert wildcards to the proper format, e.g., no need to use capture groups
alias mmv='noglob zmv -W'

# neovim
alias vim='nvim'
alias vimdiff='nvim -d '

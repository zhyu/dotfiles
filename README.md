# dotfiles

## Requirements

- zsh
- git
- [Homebrew](https://brew.sh/) (macOS only)

## External dependencies managed with git subtree

```sh
❯ git log | rg 'git-subtree-dir:\s*(.+)$' -r '$1' | sort -u
    fzf
    tmux/tpm
    zsh/ohmyzsh
    zsh/ohmyzsh/custom/plugins/fasd
    zsh/ohmyzsh/custom/plugins/fast-syntax-highlighting
    zsh/ohmyzsh/custom/plugins/fzf-tab
    zsh/ohmyzsh/custom/plugins/zsh-autosuggestions
    zsh/ohmyzsh/custom/themes/powerlevel10k
```

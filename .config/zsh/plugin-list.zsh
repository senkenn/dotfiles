# fzf
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

# history with fzf
function fzf-select-history() {
  BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions

# fast-syntax-highlighting
zinit light z-shell/F-Sy-H

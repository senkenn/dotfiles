# Load powerlevel10k theme
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k
source $HOME/.config/zsh/.p10k.zsh

# is_docker() {
#   local systemd_path="/run/systemd/container"

#   # ファイルが存在する場合に判定
#   if [[ -f "$systemd_path" ]]; then
#     local container_type=$(cat "$systemd_path" | tr -d '[:space:]')
#     [[ "$container_type" == "docker" ]]
#     return 0
#   fi

#   return 1
# }

# # powerlevel10k に Docker 情報を表示するカスタム関数を追加
# function prompt_custom_docker() {
#   if is_docker; then
#     echo "%F{red}Docker%f" # Docker 実行中なら赤で表示
#   fi
# }

# # # プロンプトに追加
# # POWERLEVEL9K__PROMPT_ELEMENTS=(... custom_docker) # 必要な場所に追加

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

# pnpm completion
zinit ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
zinit light g-plane/pnpm-shell-completion

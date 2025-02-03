# Enable word jumping with ctrl + arrow keys
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# メニュー選択モードでのキーマップをviinsに設定する
bindkey -N menuselect viins

# メニュー選択を有効にする
zstyle ':completion:*' menu select

# 補完候補を矢印キーで移動できるようにする
bindkey -M menuselect '^[[A' up-line-or-history
bindkey -M menuselect '^[[B' down-line-or-history

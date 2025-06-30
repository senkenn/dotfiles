#!/bin/bash

curl -fsSL https://get.pnpm.io/install.sh | env SHELL=/bin/zsh sh -
echo "source $HOME/.config/pnpm/pnpm-completion.zsh" >>"$HOME"/.zshrc

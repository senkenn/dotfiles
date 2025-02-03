#!/bin/bash

curl -fsSL https://get.pnpm.io/install.sh | env SHELL=/bin/zsh sh -

# pnpm completion
pnpm completion zsh >"$HOME"/.config/zsh/completion-for-pnpm.zsh
echo "source ""$HOME""/.config/zsh/completion-for-pnpm.zsh" >>~/.zshrc

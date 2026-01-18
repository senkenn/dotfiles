#!/bin/bash

set -euo pipefail

curl -fsSL https://get.pnpm.io/install.sh | sh -

# Set up pnpm completion for zsh
mkdir -p ~/.config/pnpm
pnpm completion zsh > ~/.config/pnpm/completion-for-pnpm.zsh
cat << 'EOF' >> "$HOME/.zshrc"

# pnpm completion
source "$HOME/.config/pnpm/completion-for-pnpm.zsh"
EOF

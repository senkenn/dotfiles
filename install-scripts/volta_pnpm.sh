#!/bin/bash

set -euo pipefail

volta install pnpm

# Set up pnpm completion for zsh
mkdir -p ~/.config/pnpm
pnpm completion zsh > ~/.config/pnpm/completion-for-pnpm.zsh
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
cat << 'EOF' >> "$HOME/.zshrc"

# pnpm completion
source "$HOME/.config/pnpm/completion-for-pnpm.zsh"
EOF

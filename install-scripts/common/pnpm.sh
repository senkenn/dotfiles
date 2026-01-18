#!/bin/bash

set -euo pipefail

case "$(uname -s)" in
  Darwin)
    brew install pnpm
    ;;
  Linux)
    sudo apt update && sudo apt install -y pnpm
    ;;
esac

# Set up pnpm completion for zsh
mkdir -p ~/.config/pnpm
pnpm completion zsh > ~/.config/pnpm/completion-for-pnpm.zsh
cat << 'EOF' >> "$HOME/.zshrc"

# pnpm completion
source "$HOME/.config/pnpm/completion-for-pnpm.zsh"
EOF

#!/usr/bin/env bash

set -e

# Install Neovim
case "$(uname -s)" in
  Darwin) brew install neovim ;;
  Linux) sudo apt install -y neovim ;;
  *) echo "Unsupported OS"; exit 1 ;;
esac

# Install lazy.nvim
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
  git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
    --branch=stable "$LAZY_PATH"
fi

echo "nvim: Done!"

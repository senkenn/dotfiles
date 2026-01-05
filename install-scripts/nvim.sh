#!/usr/bin/env bash

set -e

# Install Neovim
sudo apt install -y neovim

# Install lazy.nvim
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
  git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
    --branch=stable "$LAZY_PATH"
fi

echo "nvim: Done!"

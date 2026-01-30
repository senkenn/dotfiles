#!/usr/bin/env bash
set -e

OS=$(uname -s)

case "$OS" in
  Darwin)
    brew install mise
    ;;
  Linux)
    sudo apt update && sudo apt install -y gpg sudo wget curl
    sudo install -dm 755 /etc/apt/keyrings
    wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
    sudo apt update && sudo apt install -y mise
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

echo 'eval "$(mise activate zsh)"' >> "$HOME"/.zshrc

mise install

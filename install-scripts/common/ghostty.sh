#!/bin/bash
set -euo pipefail

echo "=== Installing Ghostty ==="

if [[ "$OSTYPE" == "darwin"* ]]; then
  brew install --cask ghostty
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://release.files.ghostty.org/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/ghostty.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/ghostty.gpg] https://release.files.ghostty.org/apt stable main" | sudo tee /etc/apt/sources.list.d/ghostty.list > /dev/null
  sudo apt update
  sudo apt install -y ghostty
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi

echo "=== Ghostty installation complete ==="

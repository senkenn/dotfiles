#!/bin/bash
set -euo pipefail

echo "=== Installing GitHub CLI ==="

if [[ "$OSTYPE" == "darwin"* ]]; then
  brew install gh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt install -y gh
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi

echo "=== GitHub CLI installation complete ==="

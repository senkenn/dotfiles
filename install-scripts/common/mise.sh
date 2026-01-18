#!/bin/bash
set -euo pipefail

echo "=== Installing mise ==="

curl https://mise.run | sh

echo 'eval "$(~/.local/bin/mise activate zsh)"' >> "$HOME"/.zshrc

~/.local/bin/mise install

echo "=== mise installation complete ==="

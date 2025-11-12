#!/bin/bash

set -euo pipefail

# Detect OS and install trash-cli
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  brew install trash-cli
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  sudo apt install -y trash-cli
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi

# Configure shell for trash-cli
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS: Add PATH and alias
  cat <<'EOF' >> ~/.zshrc

# trash-cli
export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"
alias rm="trash-put"
EOF
else
  # Linux: Add alias only
  cat <<'EOF' >> ~/.zshrc

# trash-cli
alias rm="trash-put"
EOF
fi

#!/bin/bash

sudo apt install -y trash-cli

# aliases
cat <<'EOF' >> ~/.zshrc

# trash-cli
alias rm="trash-put"
EOF

#!/usr/bin/env bash

set -e

case "$(uname -s)" in
  Darwin) brew install tmux ;;
  Linux) sudo apt install -y tmux ;;
  *) echo "Unsupported OS"; exit 1 ;;
esac

# tmux plugin manager (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

#!/usr/bin/env bash

sudo apt update && sudo apt install -y curl zsh

# zinit: plugin manager
# https://github.com/zdharma-continuum/zinit
yes | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

current_dir=$(dirname "$(realpath "$0")")
ln -s "$current_dir/.config" "$HOME"
echo "source $current_dir/.config/zsh/.zshrc" >>"$HOME"/.zshrc

# run commands in .config/rc
for rc in "$current_dir"/rc/*.sh; do
  bash "$rc"
done

echo "dotfiles installer: Done!"

export GIT_PROGRESS=false
zsh

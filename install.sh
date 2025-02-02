#!/usr/bin/env bash

sudo apt update && sudo apt install -y curl zsh openssh-client zip

# zinit: plugin manager
# https://github.com/zdharma-continuum/zinit
yes | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

current_dir=$(dirname "$(realpath "$0")")

# cp .config/* to "$HOME"
mkdir -p "$HOME"/.config
for config in "$current_dir"/.config/*; do
  # if exists, skip
  [ -d "$HOME"/.config/"$(basename "$config")" ] && continue
  cp -r "$config" "$HOME"/.config
done
echo "source $current_dir/.config/zsh/.zshrc" >>"$HOME"/.zshrc

# run commands in .config/rc
for rc in "$current_dir"/rc/*.sh; do
  bash "$rc"
done

# Change default shell to zsh
sudo chsh -s "$(which zsh)" "$USER"

echo "dotfiles installer: Done!"

zsh

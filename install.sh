#!/usr/bin/env bash

set -e

sudo apt update && sudo apt install -y curl zsh openssh-client zip build-essential

current_dir=$(dirname "$(realpath "$0")")

# prezto: configuration framework, aliases, functions, auto completion, ...
zsh "$current_dir"/prompt-installing/prezto.zsh

# zinit: plugin manager
# https://github.com/zdharma-continuum/zinit
yes | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# symlink .config/* to "$HOME"/.config
mkdir -p "$HOME"/.config
for config in "$current_dir"/.config/*; do
  target="$HOME"/.config/"$(basename "$config")"
  # if exists, skip
  [ -e "$target" ] && continue
  ln -s "$config" "$target"
done
echo "source $HOME/.config/zsh/.zshrc" >>"$HOME"/.zshrc

# install tools
for script in "$current_dir"/install-scripts/*.sh; do
  bash "$script" || {
    echo "$script" failed.
    exit 1
  }
done

# Change default shell to zsh
sudo chsh -s "$(which zsh)" "$(whoami)"

# no password for sudo
echo "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/"$(whoami)"

echo "dotfiles installer: Done!"

zsh

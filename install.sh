#!/usr/bin/env bash
set -e

OS=$(uname -s)
current_dir=$(dirname "$(realpath "$0")")

# OS-specific directory
case "$OS" in
  Linux)  os_dir="linux" ;;
  Darwin) os_dir="macos" ;;
  *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

# Linux-specific base packages
if [ "$OS" = "Linux" ]; then
  sudo apt update && sudo apt install -y curl zsh openssh-client zip build-essential
fi

# prezto
zsh "$current_dir"/prompt-installing/prezto.zsh

# zinit
yes | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# symlink configs (common + OS-specific)
mkdir -p "$HOME"/.config
for dir in common "$os_dir"; do
  config_dir="$current_dir/config/$dir"
  [ -d "$config_dir" ] || continue
  for config in "$config_dir"/*; do
    [ -d "$config" ] || continue
    target="$HOME/.config/$(basename "$config")"
    [ -e "$target" ] && continue
    ln -s "$config" "$target"
  done
done

echo "source $HOME/.config/zsh/.zshrc" >> "$HOME"/.zshrc

# run install scripts (common + OS-specific)
for dir in common "$os_dir"; do
  script_dir="$current_dir/install-scripts/$dir"
  [ -d "$script_dir" ] || continue
  for script in "$script_dir"/*.sh; do
    [ -f "$script" ] || continue
    bash "$script" || { echo "$script failed."; exit 1; }
  done
done

# Linux-specific post-install
if [ "$OS" = "Linux" ]; then
  sudo chsh -s "$(which zsh)" "$(whoami)"
  echo "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/"$(whoami)"
fi

echo "dotfiles installer: Done!"
zsh

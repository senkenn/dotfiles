#!/usr/bin/env bash
set -euo pipefail

sudo apt update -y
sudo apt install -y fcitx5 fcitx5-mozc fcitx5-configtool
im-config -n fcitx5
cp $current_dir/.config/fcitx5/profile ~/.config/fcitx5/profile

# autostart fcitx5
mkdir -p ~/.config/autostart && cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart

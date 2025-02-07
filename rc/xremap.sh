#!/bin/bash

# install xremap
zsh -c "cargo install xremap --features gnome"

# start xremap automatically on boot
sudo cp $current_dir/.config/xremap/xremap.service /etc/systemd/system/
sudo systemctl enable xremap.service

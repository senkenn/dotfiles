#!/bin/bash

# show all gsettings
# gsettings list-schemas | gsettings list-recursively

# keybindings
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Page_Up', '<Super><Alt>Left', '<Control><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Page_Down', '<Super><Alt>Right', '<Control><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Control><Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Control><Super>Down']"
gsettings set org.gnome.desktop.wm.keybindings begin-resize "['<Super>F8']" # Because it conflicts with "Alt + F8" in VSCode
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['Print', '<Super><Shift>s']"
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Ctrl><Super>v', '<Super>m']"
gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]" # previous setting: ['<Control>period', '<Control>semicolon']

# UI
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface font-name 'Noto Sans CJK JP 11' # Fix windswitcher extending and retracting up and down.
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position "BOTTOM"
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'code.desktop', 'org.gnome.Nautilus.desktop', 'discord.desktop', 'slack_slack.desktop']"

# Others
gsettings set org.gnome.mutter workspaces-only-on-primary false                              # workspaces on all displays
gsettings set org.gnome.desktop.input-sources sources "[('ibus', 'mozc-jp'), ('xkb', 'jp')]" # Change the order of input sources
gsettings set org.gnome.desktop.session idle-delay "uint32 900"
gsettings set org.gnome.desktop.screensaver lock-enabled false

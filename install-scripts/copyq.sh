#!/bin/bash

sudo apt install -y copyq

# copyq is not working by default: https://github.com/hluk/CopyQ/issues/2889
# workaround: https://itsfoss.community/t/solved-copyq-not-saving-clipboard-copy-paste-in-ubuntu/10829/2
# This .config/copyq/copyq.desktop was created by following steps:
#   1. Check the "Autostart" box in the CopyQ settings
#   2. cp ~/.config/autostart/copyq.desktop ~/.config/autostart/copyq.desktop~
#   3. sed -i 's@Exec="/usr/bin/copyq"@Exec=env QT_QPA_PLATFORM=xcb copyq@' ~/.config/autostart/copyq.desktop
cp $current_dir/.config/copyq/copyq.desktop ~/.config/autostart/copyq.desktop

# set the custom keyboard shortcut for "copyq show", because copyq's global shortcut not work in Firefox.

# 0. Remove conflicting shortcut:
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>m']"

# 1. Find the next available custom keybinding index:
existing_keys_output=$(dconf list /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/)
existing_indices=$(echo "$existing_keys_output" | grep -o "^custom[0-9]*/$" | sed 's/custom//' | sed 's/\/$//' | sort -n | tail -n 1)

new_index=0
if [ -n "$existing_indices" ]; then
  new_index=$((existing_indices + 1))
fi
new_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${new_index}/"
# echo "Using new path: ${new_path}"

# 2. Add the new path to the list of custom keybindings:
current_bindings_string=$(dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings)
current_bindings_string=$(echo "$current_bindings_string" | tr -d '\n') # Remove trailing newline

if [[ "$current_bindings_string" == "[]" ]]; then
  # If the list is empty, create a new list with the new path
  updated_bindings="['${new_path}']"
else
  # Otherwise, remove the closing ']' and append the new path
  temp_bindings=$(echo "$current_bindings_string" | sed 's/]$//')
  updated_bindings="${temp_bindings}, '${new_path}']"
fi

# Write the updated list back to dconf
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ "$updated_bindings"

# 3. Set the name, command, and key binding for the new shortcut:
# Set the Name (how it appears in GUI settings)
dconf write "${new_path}name" "'Show CopyQ'"

# Set the Command to be executed
dconf write "${new_path}command" "'copyq show'"

# Set the Key Binding
desired_binding="'<Super>v'"
dconf write "${new_path}binding" "${desired_binding}"

# echo "Custom shortcut 'Show CopyQ' set with command 'copyq show' and binding ${desired_binding}."

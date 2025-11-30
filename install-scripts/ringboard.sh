#!/bin/bash

set -euo pipefail

# install pkg-config, fontconfig, ydotool(for my auto paste)
sudo apt install pkg-config libfontconfig1-dev ydotool -y

# install ringbaord
git clone git@github.com:senkenn/clipboard-history.git -b ~/senkenn
cd ~/senkenn/clipboard-history
./install-with-cargo-systemd.sh
cd egui
cargo build --release --bin ringboard-egui --features "${XDG_SESSION_TYPE}",system-fonts
cargo build --release --bin ringboard-auto-paste

configure_ringboard_shortcut() {
    local schema="org.gnome.settings-daemon.plugins.media-keys"
    local key="custom-keybindings"
    local binding_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ringboard-auto-paste/"
    local entry_schema="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${binding_path}"
    local shortcut_name="Ringboard Auto Paste"
    local shortcut_binding="<Super>v"
    local shortcut_command='/bin/sh -c "ps -p `cat /tmp/.ringboard/senken.egui-sleep 2> /dev/null` > /dev/null 2>&1 && exec rm -f /tmp/.ringboard/senken.egui-sleep || /home/senken/senkenn/clipboard-history/target/release/ringboard-auto-paste"'

    if ! command -v gsettings >/dev/null 2>&1; then
        echo "gsettings command not found; skipping custom shortcut setup." >&2
        return
    fi

    SCHEMA="$schema" KEY="$key" PATH="$binding_path" python3 <<'PY'
import ast
import os
import subprocess
import sys

schema = os.environ["SCHEMA"]
key = os.environ["KEY"]
path = os.environ["PATH"]

try:
    result = subprocess.run(
        ["gsettings", "get", schema, key],
        check=True,
        capture_output=True,
        text=True,
    ).stdout.strip()
except subprocess.CalledProcessError:
    print(
        "Failed to read GNOME custom keybindings; skipping shortcut setup.",
        file=sys.stderr,
    )
    sys.exit(0)

if result.startswith("@"):
    result = result.split(" ", 1)[1]

paths = ast.literal_eval(result)
if path not in paths:
    paths.append(path)
    subprocess.run(
        ["gsettings", "set", schema, key, str(paths)],
        check=True,
    )
PY

    gsettings set "${entry_schema}" name "$shortcut_name"
    gsettings set "${entry_schema}" command "$shortcut_command"
    gsettings set "${entry_schema}" binding "$shortcut_binding"
}

configure_ringboard_shortcut

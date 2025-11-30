#!/bin/bash
set -e # エラーが発生したら即停止

echo "=== 🚀 Ubuntu Setup: Alacritty Only (Rust assumed installed) ==="

# 1. ビルドに必要な依存ライブラリのインストール
# Alacritty は Rust 製ですが、ビルドには C のライブラリ(フォント描画やウィンドウ管理)が必要です
echo "--> 📦 Installing build dependencies..."
sudo apt update
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# 2. Alacritty のインストール (Cargoを使用)
# 既存の Rust 環境を使ってビルドします
echo "--> 🏗️ Compiling Alacritty (This may take a few minutes)..."
cargo install alacritty

# 3. Alacritty の設定 (alacritty.toml)
# 起動時に最大化する設定のみ記述します
echo "--> ⚙️ Configuring Alacritty..."
mkdir -p ~/.config/alacritty
cat <<EOF > ~/.config/alacritty/alacritty.toml
[window]
startup_mode = "Maximized"
decorations = "full"
opacity = 0.95

[font]
size = 13.0

[keyboard]

[[keyboard.bindings]]
key = "C"
mods = "Control"
action = "Copy"

[[keyboard.bindings]]
key = "V"
mods = "Control"
action = "Paste"
EOF

# 4. Ubuntu ログイン時の自動起動設定
# ~/.config/autostart に .desktop ファイルを作成します
echo "--> 🏃 Setting up Autostart..."
mkdir -p ~/.config/autostart
USER_CARGO_BIN="$HOME/.cargo/bin/alacritty"

# 念のためバイナリの場所を確認
if [ ! -f "$USER_CARGO_BIN" ]; then
    echo "⚠️ Warning: Alacritty binary not found at $USER_CARGO_BIN"
    echo "Check your cargo bin path."
fi

cat <<EOF > ~/.config/autostart/alacritty.desktop
[Desktop Entry]
Type=Application
Exec=env GTK_THEME=Yaru:dark $USER_CARGO_BIN
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Alacritty
Comment=Start Alacritty at login
Icon=utilities-terminal
EOF

echo "=== 🎉 Setup Complete! ==="
echo "Please logout and login again to see Alacritty start automatically."

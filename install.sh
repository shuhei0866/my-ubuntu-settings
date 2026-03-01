#!/bin/bash
# my-ubuntu-settings インストールスクリプト
# Mac風Ubuntu環境のセットアップ

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== my-ubuntu-settings installer ==="
echo ""

# --- パッケージインストール ---
echo "[1/5] Installing packages..."
sudo apt-get update -qq
sudo apt-get install -y keyd libinput-gestures xdotool

# --- keyd 設定 ---
echo "[2/5] Setting up keyd..."
sudo cp "$SCRIPT_DIR/keyd/default.conf" /etc/keyd/default.conf
sudo systemctl enable keyd
sudo systemctl restart keyd
echo "  keyd configured and restarted."

# --- GNOME キーバインド ---
echo "[3/5] Applying GNOME keybindings..."
bash "$SCRIPT_DIR/gnome/apply.sh"

# --- ジェスチャー ---
echo "[4/5] Setting up gestures..."
mkdir -p ~/.config
cp "$SCRIPT_DIR/gestures/libinput-gestures.conf" ~/.config/libinput-gestures.conf
mkdir -p ~/.config/autostart
cp "$SCRIPT_DIR/autostart/libinput-gestures.desktop" ~/.config/autostart/libinput-gestures.desktop
# libinput-gestures を再起動（実行中なら）
libinput-gestures-setup restart 2>/dev/null || libinput-gestures-setup start 2>/dev/null || true
echo "  gestures configured."

# --- シェル設定 ---
echo "[5/5] Setting up shell configs..."

# .zpreztorc
if [ -f ~/.zpreztorc ]; then
    echo "  ~/.zpreztorc exists, backing up to ~/.zpreztorc.bak"
    cp ~/.zpreztorc ~/.zpreztorc.bak
fi
ln -sf "$SCRIPT_DIR/shell/.zpreztorc" ~/.zpreztorc

# .bash_aliases
if [ -f ~/.bash_aliases ] && [ ! -L ~/.bash_aliases ]; then
    echo "  ~/.bash_aliases exists, backing up to ~/.bash_aliases.bak"
    cp ~/.bash_aliases ~/.bash_aliases.bak
fi
ln -sf "$SCRIPT_DIR/shell/.bash_aliases" ~/.bash_aliases

# .xprofile
if [ -f ~/.xprofile ] && [ ! -L ~/.xprofile ]; then
    echo "  ~/.xprofile exists, backing up to ~/.xprofile.bak"
    cp ~/.xprofile ~/.xprofile.bak
fi
ln -sf "$SCRIPT_DIR/shell/.xprofile" ~/.xprofile

# .zshrc: zprezto が管理するため、zprezto がインストール済みならスキップ
if [ -d ~/.zprezto ]; then
    echo "  zprezto detected. Skipping .zshrc (managed by zprezto)."
    echo "  If needed, replace ~/.zprezto/runcoms/zshrc with shell/.zshrc"
else
    echo "  zprezto not found. Install it first:"
    echo "    git clone --recursive https://github.com/sorin-ionescu/prezto.git \"\${ZDOTDIR:-\$HOME}/.zprezto\""
fi

echo ""
echo "=== Setup complete ==="
echo "Notes:"
echo "  - keyd is active. Test Cmd+C, Cmd+V, Cmd+Tab, Cmd+Q, Cmd+Space"
echo "  - GNOME keybindings applied. Test Ctrl+Left/Right for workspace switching"
echo "  - Gestures active. Test 3-finger swipe for browser back/forward"
echo "  - Log out and back in for all changes to take full effect"

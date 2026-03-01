#!/bin/bash
# GNOME キーバインド設定スクリプト
# デフォルトから変更している設定のみ適用する

set -euo pipefail

echo "Applying GNOME keybindings..."

# ワークスペース移動: Ctrl+←/→ (Mac の Ctrl+←/→ と同じ)
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control>Right']"

# ウィンドウ切り替え: Ctrl+` (keyd経由で Cmd+` → Ctrl+`)
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Control>grave']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Control><Shift>grave']"

# 入力ソース切り替え: Ctrl+Space (Mac と同じ)
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Control>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Shift><Control>space']"

# toggle-overview を無効化 (keyd command レイヤーとの競合回避)
gsettings set org.gnome.shell.keybindings toggle-overview "[]"

echo "Done."

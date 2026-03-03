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

# アプリ切り替え: Alt+Tab (keyd の swap(command_tab) 経由で Cmd+Tab → Alt+Tab)
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Alt>Tab']"

# toggle-overview: ジェスチャーから呼び出すために Super+F12 を割り当て
# (Super 単押しは keyd command レイヤーと競合するため使えない)
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>F12']"

# スクリーンショット: Mac 風 (Cmd+Shift+3/4/5 → keyd 経由で Ctrl+Shift+3/4/5)
# Cmd+Shift+3 → 全画面スクショ（即保存）
gsettings set org.gnome.shell.keybindings screenshot "['<Ctrl><Shift>3']"
# Cmd+Shift+4 → スクショUI（範囲選択）
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Ctrl><Shift>4']"
# Cmd+Shift+5 → 画面録画UI
gsettings set org.gnome.shell.keybindings show-screen-recording-ui "['<Ctrl><Shift>5']"

echo "Done."

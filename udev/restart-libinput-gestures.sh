#!/bin/bash
# udev から呼ばれ、libinput-gestures を再起動する
sleep 2  # デバイス初期化を待つ

# 同時実行を防止（タッチパッドは複数の input デバイスを登録するため）
exec 200>/tmp/restart-libinput-gestures.lock
flock -n 200 || exit 0

# 既存の libinput-gestures を停止
pkill -f '/usr/bin/libinput-gestures' 2>/dev/null
sleep 1

# アクティブなグラフィカルセッションのユーザーを探す
user=""
while read -r sid _ u _ _; do
    type=$(loginctl show-session "$sid" -p Type --value 2>/dev/null)
    if [ "$type" = "x11" ] || [ "$type" = "wayland" ]; then
        user="$u"
        break
    fi
done < <(loginctl list-sessions --no-legend)
[ -z "$user" ] && exit 0

uid=$(id -u "$user")

# DISPLAY を取得（gnome-shell の環境変数から）
display=":0"
shell_pid=$(pgrep -u "$user" -x gnome-shell 2>/dev/null | head -1)
if [ -n "$shell_pid" ]; then
    d=$(tr '\0' '\n' < "/proc/$shell_pid/environ" 2>/dev/null | grep '^DISPLAY=' | head -1 | cut -d= -f2-)
    [ -n "$d" ] && display="$d"
fi

# 独立した transient unit として起動（このスクリプトの unit 終了後も生存する）
systemd-run --no-block --uid="$user" \
  --setenv=DISPLAY="$display" \
  --setenv=XAUTHORITY="/home/$user/.Xauthority" \
  --setenv=XDG_RUNTIME_DIR="/run/user/$uid" \
  /usr/bin/libinput-gestures

exit 0

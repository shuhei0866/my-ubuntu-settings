#!/bin/bash
# udev から呼ばれ、libinput-gestures を再起動する
sleep 2  # デバイス初期化を待つ

# 実行中プロセスから環境情報を取得して再起動
pid=$(pgrep -xf "python3 /usr/bin/libinput-gestures" | head -1)

if [ -n "$pid" ]; then
    user=$(stat -c '%U' "/proc/$pid")
    display=$(tr '\0' '\n' < "/proc/$pid/environ" 2>/dev/null | grep '^DISPLAY=' | head -1 | cut -d= -f2-)
    kill "$pid" 2>/dev/null
    sleep 1
else
    # プロセスが存在しない場合、アクティブなグラフィカルセッションのユーザーを探す
    while read -r sid uid u seat _; do
        type=$(loginctl show-session "$sid" -p Type --value 2>/dev/null)
        if [ "$type" = "x11" ] || [ "$type" = "wayland" ]; then
            user="$u"
            break
        fi
    done < <(loginctl list-sessions --no-legend)
    [ -z "$user" ] && exit 0
fi

uid=$(id -u "$user")
display=${display:-:0}

runuser -u "$user" -- env \
  DISPLAY="$display" \
  XAUTHORITY="/home/$user/.Xauthority" \
  XDG_RUNTIME_DIR="/run/user/$uid" \
  /usr/bin/libinput-gestures &

exit 0

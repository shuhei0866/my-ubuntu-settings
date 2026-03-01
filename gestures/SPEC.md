# ジェスチャー仕様書

libinput-gesturesを使って、MacBookのトラックパッドジェスチャーをUbuntuで再現する。

## 設計方針

- Macの直感的なジェスチャー操作をできるだけ再現
- libinput-gesturesでスワイプを検知し、xdotoolでキー入力に変換

## ジェスチャー一覧

| Mac操作 | ジェスチャー | 送出キー | Ubuntu上の動作 |
|---------|------------|---------|---------------|
| 2本指スワイプ左右（Safari戻る/進む） | 3本指スワイプ右 | Alt+Left | ブラウザ戻る |
| 2本指スワイプ左右（Safari戻る/進む） | 3本指スワイプ左 | Alt+Right | ブラウザ進む |

**注意**: Macでは2本指スワイプだが、Ubuntuでは2本指はスクロールに使われるため3本指で代替。

## 依存パッケージ

- `libinput-gestures`: ジェスチャー検知デーモン
- `xdotool`: キー入力シミュレーション

## 自動起動

`autostart/libinput-gestures.desktop` でログイン時に自動起動する。

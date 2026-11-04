---
description: >
  キーバインド・キーマッピングの追加・変更・修正を依頼されたとき、
  または keyd の設定について質問されたときに使用する。
  例: 「Cmd+Xで○○したい」「Ctrl+○が効かない」「キーバインド追加して」「keydの設定見せて」
---

# keyd 設定スキル

## 概要
Ubuntu 上で Mac ライクなキーバインドを実現する keyd の設定を管理する。

## ファイル
- 設定ファイル（正本）: `~/my-ubuntu-settings/keyd/default.conf`
  - keyd が読むのは root 所有の写し `/etc/keyd/default.conf`。2026-11-04 にシンボリックリンクをやめた。keyd は root で動き、`command()` も root で実行するため、利用者が書けるファイルを直接読ませない（IAM-818）
- 仕様書: `~/my-ubuntu-settings/keyd/SPEC.md`

## 手順

1. まず `~/my-ubuntu-settings/keyd/SPEC.md` を読んで現在の設計方針とマッピング一覧を把握する
2. `~/my-ubuntu-settings/keyd/default.conf` を読んで現在の設定を確認する
3. 設定ファイル（正本）を編集する（Edit ツールで直接編集可能）
4. 写しへ反映して keyd を再起動する。写しの更新は root の作業なので、パスワードが要る:
   `sudo install -m 644 ~/my-ubuntu-settings/keyd/default.conf /etc/keyd/default.conf && sudo /usr/bin/systemctl restart keyd`
   （restart と `keyd reload` はパスワード不要、install はパスワードが要る）。エージェントは編集とこのコマンドの提示までを行い、反映は本人が実行する
5. 変更内容に応じて SPEC.md のマッピング一覧も更新する

## keyd 設定の注意点

- 修飾キーレイヤーをオーバーライドする場合はベース修飾子を付ける（例: `[control:C]`）。付けないと他のキーの修飾が失われる
- composite layer（例: `[control+shift]`）にはベース修飾子を付けない。明示的マッピングに加算されて意図しない動作になる
- `[command:C]` の仮想 Ctrl は `[control]` レイヤーの影響を受ける
- コマンド実行が必要な場合は `command()` を使う（例: `q = command(loginctl lock-session)`）。`command()` は root で実行されるので、固定の信頼できるコマンドだけにする
- GNOME 側のキーバインドと競合する場合は `gsettings` で GNOME 側を無効化する

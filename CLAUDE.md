# my-ubuntu-settings - Project Instructions

Ubuntu を Mac ライクにするための設定リポジトリ。

## 構造

```
keyd/default.conf          — キーリマッピング（/etc/keyd/default.conf にコピーして使う）
gnome/apply.sh             — GNOME ショートカット適用スクリプト
gestures/libinput-gestures.conf — トラックパッドジェスチャー
shell/.bash_aliases, .zpreztorc, .xprofile, .zshrc — シェル設定（symlink 運用）
autostart/libinput-gestures.desktop — 自動起動
udev/                      — トラックパッド再接続時の自動復旧
install.sh                 — 一括セットアップ（sudo 含む、対話的に実行）
```

## 設定変更のワークフロー

1. このリポジトリ内のファイルを編集する（sudo 不要）
2. 適用に sudo が必要なもの（keyd, udev）は、コマンドをユーザーに提示する
3. 動作確認後にコミットする

## keyd 設定変更時の必須手順

keyd は Mac ライクなキーリマッピングの要。変更前に必ず：

1. **現在の設定を読む**: `keyd/default.conf` の全内容を理解してから変更する
2. **GNOME ショートカットとの競合チェック**:
   ```
   gsettings list-recursively org.gnome.desktop.wm.keybindings
   gsettings list-recursively org.gnome.shell.keybindings
   gsettings list-recursively org.gnome.mutter.keybindings
   ```
3. **変更後の diff を確認**: `git diff keyd/default.conf`
4. **適用コマンドを提示**（直接実行しない）:
   ```
   sudo cp keyd/default.conf /etc/keyd/default.conf && sudo keyd reload
   ```

### keyd でよくある間違い

- **アプリ切り替え（Cmd+Tab）は `swap()` が必須**。単純な `A-tab` だと Alt が一瞬で離されてスイッチャーが閉じる
- **GNOME が Super キーを横取りする**。`M-space` 等の出力が Activities を開いてしまう場合がある
- **composite layer は基本レイヤーの定義順序に依存する**

## GNOME 設定変更

- `gnome/apply.sh` に `gsettings set` コマンドを追加する形で管理
- 変更前に現在値を `gsettings get` で確認する
- GNOME のキーバインドと keyd のマッピングの両方を考慮する（物理キー → keyd 変換後 → GNOME が受け取るキー）

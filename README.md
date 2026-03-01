# my-ubuntu-settings

Ubuntu上でMac風の操作環境を構築するための設定ファイル一式。

## 概要

MacからUbuntuに移行した際に、できるだけMacと同じキーバインドやジェスチャーで操作できるようにする。

### レイヤー構成

| レイヤー | ツール | 役割 |
|---------|-------|------|
| キーリマップ | keyd | Cmd→Ctrl変換、Mac固有ショートカットの実装 |
| デスクトップ | GNOME keybindings | ワークスペース移動、ウィンドウ切り替え、IME切り替え |
| ジェスチャー | libinput-gestures | トラックパッドのスワイプジェスチャー |
| シェル | zsh + prezto | ターミナル環境 |

## ディレクトリ構成

```
keyd/
  SPEC.md          # keydの仕様: どのキーを何に対応させるか
  default.conf     # keydの設定ファイル (/etc/keyd/default.conf にコピー)
gnome/
  SPEC.md          # GNOMEキーバインドの仕様
  apply.sh         # gsettingsで適用するスクリプト
gestures/
  SPEC.md          # ジェスチャーの仕様
  libinput-gestures.conf  # libinput-gestures設定
shell/
  .zshrc           # zsh設定 (zprezto)
  .zpreztorc       # prezto設定
  .bash_aliases    # bash/zsh共通エイリアス
  .xprofile        # X11プロファイル
autostart/
  libinput-gestures.desktop  # ジェスチャーデーモンの自動起動
```

## セットアップ

```bash
git clone git@github.com:shuhei0866/my-ubuntu-settings.git ~/my-ubuntu-settings
cd ~/my-ubuntu-settings
./install.sh
```

## 主なキー操作

| Mac操作 | Ubuntu上の動作 | 実装レイヤー |
|---------|---------------|-------------|
| Cmd+C/V/X/Z | コピー/ペースト等 | keyd (Cmd→Ctrl) |
| Cmd+Tab | アプリ切り替え | keyd (Cmd→Ctrl) |
| Cmd+Q | アプリ終了 | keyd → Alt+F4 |
| Cmd+Space | ランチャー | keyd → Super+Space |
| Cmd+H | ウィンドウを隠す | keyd → Super+H → GNOME minimize |
| Cmd+` | 同一アプリのウィンドウ切替 | keyd → Ctrl+` → GNOME switch-windows |
| Cmd+←/→ | ブラウザ戻る/進む | keyd → Alt+Left/Right |
| Cmd+Opt+←/→ | タブ移動 | keyd → Ctrl+PageUp/Down |
| Ctrl+←/→ | ワークスペース移動 | GNOME keybindings |
| Ctrl+Space | IME切り替え | GNOME keybindings |
| 3本指スワイプ | ブラウザ戻る/進む | libinput-gestures |

## 各仕様書

詳細は各ディレクトリの `SPEC.md` を参照:

- [keyd/SPEC.md](keyd/SPEC.md) - キーリマップの仕様
- [gnome/SPEC.md](gnome/SPEC.md) - GNOMEキーバインドの仕様
- [gestures/SPEC.md](gestures/SPEC.md) - ジェスチャーの仕様

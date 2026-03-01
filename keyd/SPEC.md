# keyd 仕様書

keydはカーネルレベルで動作するキーリマッパー。Macのキー配置をUbuntuで再現する。

## 設計方針

- **Meta(Super/Cmd) キーを command レイヤーとして使う**: `[command:C]` により、Cmd+○ が Ctrl+○ として送信される（デフォルト動作）
- **個別のオーバーライド**: Cmd+Q, Cmd+Space, Cmd+H, Cmd+左右 など Mac固有のショートカットは個別マッピング
- **物理 Ctrl はそのまま**: ターミナル操作(Ctrl+C等)やワークスペース移動(Ctrl+左右)に使う

## キーマッピング一覧

### command レイヤー (Cmd+○)

| Mac操作 | 物理キー | keydが送出 | Ubuntu上の動作 |
|---------|---------|-----------|---------------|
| Cmd+C/V/X/Z/A/... | Meta+○ | Ctrl+○ | コピー/ペースト等（デフォルト動作） |
| Cmd+Tab | Meta+Tab | Alt+Tab | アプリ切り替え |
| Cmd+Shift+Tab | Meta+Shift+Tab | Alt+Shift+Tab | アプリ逆切り替え |
| Cmd+T | Meta+T | Ctrl+T | 新しいタブ |
| Cmd+W | Meta+W | Ctrl+W | タブを閉じる |
| Cmd+Q | Meta+Q | Alt+F4 | アプリ終了 |
| Cmd+Space | Meta+Space | Super+Space | ランチャー（GNOME Activities） |
| Cmd+H | Meta+H | Super+H | ウィンドウを隠す（minimize） |
| Cmd+← | Meta+Left | Alt+Left | ブラウザ戻る |
| Cmd+→ | Meta+Right | Alt+Right | ブラウザ進む |

### command+control レイヤー (Cmd+Ctrl+○)

| Mac操作 | 物理キー | keydが送出 | Ubuntu上の動作 |
|---------|---------|-----------|---------------|
| Cmd+Ctrl+Q | Meta+Ctrl+Q | loginctl lock-session | 画面ロック |

### control レイヤー (Ctrl+○)

| Mac操作 | 物理キー | keydが送出 | Ubuntu上の動作 |
|---------|---------|-----------|---------------|
| Ctrl+Tab | Ctrl+Tab | Ctrl+PageDown | 次のタブへ移動 |
| Ctrl+Shift+Tab | Ctrl+Shift+Tab | Ctrl+PageUp | 前のタブへ移動 |

### command+alt レイヤー (Cmd+Option+○)

| Mac操作 | 物理キー | keydが送出 | Ubuntu上の動作 |
|---------|---------|-----------|---------------|
| Cmd+Opt+← | Meta+Alt+Left | Ctrl+PageUp | 前のタブへ移動 |
| Cmd+Opt+→ | Meta+Alt+Right | Ctrl+PageDown | 次のタブへ移動 |

## 注意事項

- keydはすべての入力デバイス(`[ids]` = `*`)に適用される
- Kinto/xkeysnailは削除済み。keydに一本化
- ターミナルでの Ctrl+C/D 等は物理Ctrlキーで操作する（Cmd経由ではない）

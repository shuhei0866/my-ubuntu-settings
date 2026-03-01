# GNOME キーバインド仕様書

keydと組み合わせて、Mac風の操作を実現するためのGNOMEキーバインド設定。

## 設計方針

- keydがCmd→Ctrlに変換するため、GNOME側は**Ctrl+○**でショートカットを受け取る
- 物理Ctrlキーで直接使うショートカットも含む（ワークスペース移動など）
- デフォルトから変更した設定のみ管理する

## カスタマイズ一覧

### ワークスペース移動

| Mac操作 | 物理キー | GNOME設定 | 動作 |
|---------|---------|----------|------|
| Ctrl+← | Ctrl+Left | `<Control>Left` | 左のワークスペースへ |
| Ctrl+→ | Ctrl+Right | `<Control>Right` | 右のワークスペースへ |

**理由**: Macでは Ctrl+←/→ でSpaces(仮想デスクトップ)を切り替える。これをそのまま再現。
デフォルト(`<Control><Alt>Left` 等)から変更している。

### ウィンドウ切り替え（同一アプリ内）

| Mac操作 | 物理キー | keyd経由 | GNOME設定 | 動作 |
|---------|---------|---------|----------|------|
| Cmd+` | Meta+` | Ctrl+` | `<Control>grave` | 同一アプリのウィンドウ切り替え |
| Cmd+Shift+` | Meta+Shift+` | Ctrl+Shift+` | `<Control><Shift>grave` | 逆方向 |

**理由**: Macでは Cmd+` で同一アプリのウィンドウを切り替える。

### 入力ソース切り替え

| Mac操作 | 物理キー | GNOME設定 | 動作 |
|---------|---------|----------|------|
| Ctrl+Space | Ctrl+Space | `<Control>space` | IME切り替え |
| Ctrl+Shift+Space | Ctrl+Shift+Space | `<Shift><Control>space` | 逆方向 |

**理由**: Macでは Ctrl+Space で入力ソースを切り替える。

### 無効化した設定

| 設定 | 値 | 理由 |
|------|---|------|
| toggle-overview | `[]` | Super+Sがkeydのcommandレイヤーと競合するため無効化 |

## 適用方法

```bash
./apply.sh
```

`gnome/apply.sh` を実行すると、上記の設定がすべて適用される。

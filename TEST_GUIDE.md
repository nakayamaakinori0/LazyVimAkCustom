# 🧪 Neovim設定テストガイド - 超初心者向け

## 📋 目次

1. [テストって何？](#テストって何)
2. [テスト環境の説明](#テスト環境の説明)
3. [テストの実行方法](#テストの実行方法)
4. [テストコードの書き方](#テストコードの書き方)
5. [実践例：新機能をテスト駆動で作る](#実践例新機能をテスト駆動で作る)
6. [トラブルシューティング](#トラブルシューティング)

---

## 🤔 テストって何？

**テスト = あなたのNeovim設定が正しく動くかを自動でチェックすること**

### なぜテストが必要？

❌ **テストがない場合**
```
設定を変更 → Neovim起動 → 手動で確認 → 「あれ？キーマップが効かない...」
→ どこで壊れたかわからない → 1時間デバッグ地獄 😱
```

✅ **テストがある場合**
```
設定を変更 → テスト実行（10秒） → 「❌ Ctrl+hが動かない」
→ すぐに問題箇所がわかる → 30秒で修正完了 😎
```

---

## 🏗️ テスト環境の説明

あなたのNeovim設定には、以下のテスト環境が用意されています：

### 📁 ファイル構成

```
~/.config/nvim/
├── tests/                    # テスト関連のフォルダ
│   ├── test_minimal.lua     # 必須機能の高速テスト
│   ├── test_config.lua      # 全機能の詳細テスト
│   └── README.md            # テスト詳細説明
├── scripts/                 # 実行スクリプト
│   └── run_tests.sh         # テスト実行用スクリプト
├── Makefile                 # 簡単コマンド集
└── TEST_GUIDE.md            # このファイル
```

### 🎯 テストの種類

| テスト名 | 用途 | 実行時間 | いつ使う？ |
|---------|------|----------|-----------|
| **minimal** | 必須機能チェック | 3秒 | 毎日の確認 |
| **config** | 全機能チェック | 15秒 | 大きな変更後 |
| **keymap** | キー操作テスト | 手動 | キーマップ変更後 |
| **health** | 設定健全性チェック | 5秒 | 問題調査時 |

---

## 🚀 テストの実行方法

### 🔰 初心者向け：3つのコマンドだけ覚えよう

```bash
# 1. 毎日の確認（3秒で終わる）
make test-minimal

# 2. 全部チェック（何か変更した後）
make test

# 3. 困った時のヘルプ
make help
```

### 📝 詳細な実行方法

#### 1️⃣ ターミナルを開く

**Mac:**
- `Command + Space` → 「ターミナル」と入力 → Enter

**Windows (WSL):**
- `Windows + R` → 「wsl」と入力 → Enter

#### 2️⃣ Neovim設定フォルダに移動

```bash
cd ~/.config/nvim
```

#### 3️⃣ テストを実行

```bash
# 🏃‍♂️ 高速テスト（毎日これを実行）
make test-minimal

# 🧪 全テスト（何か変更した時）
make test

# 🎯 キーマップテスト（キーが効かない時）
make test-keymap

# 🩺 健康診断（調子悪い時）
make test-health
```

### 📊 結果の見方

#### ✅ 成功の場合
```
🧪 Testing essential keymaps...
✅ <C-h> (window left)
✅ <C-j> (window down)
✅ <C-k> (window up)
✅ <C-l> (window right)

🎉 All tests passed!
```
→ **OKです！何も問題ありません**

#### ❌ 失敗の場合
```
🧪 Testing essential keymaps...
❌ <C-h> keymap missing (window left)
```
→ **Ctrl+hのキーマップが設定されていません**

---

## 📝 テストコードの書き方

### 🎯 基本的な考え方

**テストコード = 「もしこうなってなかったらエラーにして」という指示書**

### 📚 テンプレート

新しいテストを書く時は、このテンプレートをコピペして使ってください：

```lua
-- 📂 tests/test_my_feature.lua

-- 設定を読み込む（おまじない）
if not vim.g.mapleader then
  local config_path = vim.fn.stdpath('config')
  dofile(config_path .. '/init.lua')
end

-- エラーチェック用関数（おまじない）
local function assert_true(condition, message)
  if not condition then
    error(message or "テストが失敗しました")
  end
end

-- 🧪 ここからあなたのテスト
print("🧪 私の新機能をテスト中...")

-- 例1: キーマップがあるかチェック
local mapping = vim.fn.maparg("<leader>foo", "n")
assert_true(mapping ~= "", "<leader>fooのキーマップがありません")
print("✅ <leader>fooキーマップが設定されています")

-- 例2: 設定値をチェック
assert_true(vim.opt.number:get() == true, "行番号が表示されていません")
print("✅ 行番号が表示されています")

-- 例3: プラグインがあるかチェック
local ok, _ = pcall(require, 'telescope')
assert_true(ok, "Telescopeプラグインが見つかりません")
print("✅ Telescopeプラグインが利用可能です")

print("🎉 すべてのテストに合格しました！")
vim.cmd('qa!')  -- Neovimを終了（おまじない）
```

### 🛠️ よく使うテストパターン

#### 🔧 キーマップのテスト

```lua
-- キーマップが存在するかチェック
local function test_keymap_exists(mode, key, description)
  local mapping = vim.fn.maparg(key, mode)
  assert_true(mapping ~= "", string.format("%s (%s) がありません", key, description))
  print("✅ " .. key .. " (" .. description .. ")")
end

-- 使用例
test_keymap_exists("n", "<C-h>", "左のウィンドウに移動")
test_keymap_exists("i", "jj", "ノーマルモードに戻る")
```

#### ⚙️ 設定値のテスト

```lua
-- 設定値をチェック
local function test_option(option_name, expected_value, description)
  local actual = vim.opt[option_name]:get()
  assert_true(actual == expected_value, 
    string.format("%s は %s であるべきですが、%s になっています", 
      description, tostring(expected_value), tostring(actual)))
  print("✅ " .. description)
end

-- 使用例
test_option("number", true, "行番号表示")
test_option("tabstop", 2, "タブ幅")
test_option("expandtab", true, "タブをスペースに展開")
```

#### 🔌 プラグインのテスト

```lua
-- プラグインが利用可能かチェック
local function test_plugin_available(plugin_name)
  local ok, _ = pcall(require, plugin_name)
  assert_true(ok, plugin_name .. " プラグインが見つかりません")
  print("✅ " .. plugin_name .. " プラグインが利用可能")
end

-- 使用例
test_plugin_available("telescope")
test_plugin_available("which-key")
```

### 💡 テストを追加する手順

#### 1️⃣ テストファイルを作成

```bash
# 新しいテストファイルを作成
touch ~/.config/nvim/tests/test_my_feature.lua
```

#### 2️⃣ テンプレートを書く

上記のテンプレートをコピペして、あなたの機能に合わせて変更

#### 3️⃣ テストを実行

```bash
# あなたのテストだけ実行
nvim --headless -l tests/test_my_feature.lua

# 全テスト実行
make test
```

---

## 🎯 実践例：新機能をテスト駆動で作る

**例：新しいキーマップ `<leader>qq` で「すべてのタブを閉じる」機能を追加**

### Step 1: 失敗するテストを書く 📝

```bash
# テストファイル作成
cat > ~/.config/nvim/tests/test_close_all_tabs.lua << 'EOF'
-- 設定読み込み
if not vim.g.mapleader then
  local config_path = vim.fn.stdpath('config')
  dofile(config_path .. '/init.lua')
end

local function assert_true(condition, message)
  if not condition then
    error(message or "失敗")
  end
end

print("🧪 すべてのタブを閉じる機能をテスト...")

-- テスト: <leader>qqキーマップが存在するか
local mapping = vim.fn.maparg("<leader>qq", "n")
assert_true(mapping ~= "", "<leader>qq キーマップがありません")

print("✅ <leader>qq キーマップが設定されています")
print("🎉 テスト合格！")
vim.cmd('qa!')
EOF
```

### Step 2: テストを実行（失敗を確認） ❌

```bash
nvim --headless -l tests/test_close_all_tabs.lua
```

期待される結果：
```
🧪 すべてのタブを閉じる機能をテスト...
E5113: Error... <leader>qq キーマップがありません
```

### Step 3: 機能を実装 🔧

```bash
# keymaps.luaに追加
echo 'vim.keymap.set("n", "<leader>qq", "<cmd>tabonly | qa<cr>", { desc = "Close all tabs" })' >> ~/.config/nvim/lua/config/keymaps.lua
```

### Step 4: テストを再実行（成功を確認） ✅

```bash
nvim --headless -l tests/test_close_all_tabs.lua
```

期待される結果：
```
🧪 すべてのタブを閉じる機能をテスト...
✅ <leader>qq キーマップが設定されています
🎉 テスト合格！
```

### Step 5: 全テストを実行 🧪

```bash
make test
```

すべてのテストが通ることを確認！

---

## 🆘 トラブルシューティング

### ❓ よくある問題と解決法

#### 🔧 「make: command not found」

**問題:** `make`コマンドが見つからない

**解決法:**
```bash
# macOS
xcode-select --install

# Ubuntu/Debian
sudo apt install build-essential

# 代替方法：スクリプトを直接実行
./scripts/run_tests.sh all
```

#### 🔧 「Permission denied」

**問題:** スクリプトの実行権限がない

**解決法:**
```bash
chmod +x scripts/run_tests.sh
```

#### 🔧 「nvim: command not found」

**問題:** Neovimがインストールされていない

**解決法:**
```bash
# macOS
brew install neovim

# Ubuntu/Debian
sudo apt install neovim
```

#### 🔧 テストが途中で止まる

**問題:** プラグインの読み込みでエラー

**解決法:**
```bash
# 1. プラグインを更新
nvim -c "Lazy sync" -c "qa"

# 2. 最小テストだけ実行
make test-minimal

# 3. 健康診断
make test-health
```

### 🔍 デバッグ方法

#### 詳細なエラー情報を見る

```bash
# より詳しいエラー情報を表示
nvim -V1 --headless -l tests/test_minimal.lua
```

#### 段階的にテスト

```bash
# 1. 設定が読み込まれるかテスト
nvim --headless -c "echo 'Leader: ' . g:mapleader" -c "qa"

# 2. キーマップが存在するかテスト
nvim --headless -c "echo maparg('<C-h>', 'n')" -c "qa"

# 3. プラグインが読み込まれるかテスト
nvim --headless -c "lua print(require('lazy'))" -c "qa"
```

### 📞 助けを求める方法

問題が解決しない場合は、以下の情報を含めて質問してください：

```bash
# システム情報を収集
echo "=== System Info ==="
uname -a
nvim --version
which nvim

echo "=== Test Output ==="
make test-minimal

echo "=== Error Details ==="
nvim -V1 --headless -l tests/test_minimal.lua
```

---

## 🎓 まとめ

### 📋 毎日やること

```bash
# 1日1回、3秒でOK
make test-minimal
```

### 📋 設定を変更した時

```bash
# 変更後は必ずチェック
make test
```

### 📋 新機能を追加する時

1. **テストを先に書く** → 失敗を確認
2. **機能を実装** → テストが通るまで
3. **全テストを実行** → 他が壊れてないか確認

### 📋 覚えておくべきコマンド

| コマンド | 用途 | 頻度 |
|---------|------|------|
| `make test-minimal` | 日常チェック | 毎日 |
| `make test` | 全体チェック | 変更後 |
| `make test-health` | 問題調査 | 困った時 |
| `make help` | ヘルプ表示 | 忘れた時 |

---

## 🎉 おめでとうございます！

これであなたも**テスト駆動開発マスター**です！

もう設定変更が怖くありません。テストがあなたの設定を守ってくれます 🛡️

**Happy Coding!** 🚀

---

*💡 このガイドで分からないことがあれば、遠慮なく質問してください！*
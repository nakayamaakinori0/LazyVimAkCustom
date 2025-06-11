# 🚀 テストコマンド チートシート

## 📋 基本コマンド（これだけ覚えればOK）

```bash
# 💨 高速チェック（毎日これ）
make test-minimal

# 🧪 全チェック（変更後）
make test

# 🩺 健康診断（困った時）
make test-health

# ❓ ヘルプ（忘れた時）
make help
```

## 🔧 テストコード書き方（コピペ用）

### 📝 基本テンプレート

```lua
-- 設定読み込み（おまじない）
if not vim.g.mapleader then
  local config_path = vim.fn.stdpath('config')
  dofile(config_path .. '/init.lua')
end

-- エラーチェック関数（おまじない）
local function assert_true(condition, message)
  if not condition then
    error(message or "失敗")
  end
end

-- 🧪 あなたのテスト
print("🧪 テスト開始...")

-- ここにテストを書く

print("🎉 テスト完了！")
vim.cmd('qa!')
```

### 🎯 キーマップテスト

```lua
-- キーマップが存在するかチェック
local mapping = vim.fn.maparg("<C-h>", "n")
assert_true(mapping ~= "", "Ctrl+hがありません")
print("✅ Ctrl+h OK")
```

### ⚙️ 設定値テスト

```lua
-- 設定値をチェック
assert_true(vim.opt.number:get() == true, "行番号が無効")
print("✅ 行番号 OK")
```

### 🔌 プラグインテスト

```lua
-- プラグインが利用可能かチェック
local ok, _ = pcall(require, 'telescope')
assert_true(ok, "Telescopeなし")
print("✅ Telescope OK")
```

## 🆘 困った時

### 🔧 トラブル対応

```bash
# エラー詳細を見る
nvim -V1 --headless -l tests/test_minimal.lua

# 権限エラー
chmod +x scripts/run_tests.sh

# プラグインエラー
nvim -c "Lazy sync" -c "qa"
```

### 📞 質問する時の情報収集

```bash
# システム情報
uname -a
nvim --version

# テスト結果
make test-minimal
```

## 🎯 テスト駆動開発フロー

```
1. テスト書く → 2. 失敗確認 → 3. 実装 → 4. 成功確認 → 5. 全テスト
```

---

**🎉 これだけ覚えれば完璧！Happy Testing! 🚀**
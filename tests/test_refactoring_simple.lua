-- シンプルなリファクタリングテスト
-- 基本的な機能が動作することを確認

-- 設定読み込み
if not vim.g.mapleader then
  local config_path = vim.fn.stdpath('config')
  dofile(config_path .. '/init.lua')
end

print("🧪 リファクタリング前の基本機能確認...")

-- === 基本設定確認 ===
print("\n⚙️  基本設定:")

-- リーダーキーの確認
if vim.g.mapleader == " " then
  print("✅ リーダーキー: スペース")
else
  print("❌ リーダーキーが正しく設定されていません")
end

-- 基本オプションの確認
local checks = {
  {vim.opt.number:get(), "行番号表示"},
  {vim.opt.relativenumber:get(), "相対行番号"},
  {vim.opt.expandtab:get(), "タブ展開"},
  {vim.opt.tabstop:get() == 2, "タブ幅2"}
}

for _, check in ipairs(checks) do
  if check[1] then
    print("✅ " .. check[2])
  else
    print("❌ " .. check[2] .. " が正しく設定されていません")
  end
end

-- === プラグイン管理確認 ===
print("\n📦 プラグイン管理:")

local lazy_ok, lazy = pcall(require, 'lazy')
if lazy_ok then
  print("✅ lazy.nvim が利用可能")
  
  local plugins = lazy.plugins()
  local plugin_count = 0
  for _, _ in pairs(plugins) do
    plugin_count = plugin_count + 1
  end
  print("✅ プラグイン総数: " .. plugin_count)
else
  print("❌ lazy.nvim が利用できません")
end

-- === 重要なキーマップ確認 ===
print("\n⌨️  キーマップ:")

local key_checks = {
  {"<C-h>", "n", "ウィンドウ左移動"},
  {"<C-j>", "n", "ウィンドウ下移動"},
  {"<C-k>", "n", "ウィンドウ上移動"},
  {"<C-l>", "n", "ウィンドウ右移動"},
  {"jj", "i", "ノーマルモード"},
  {"H", "n", "行頭"},
  {"L", "n", "行末"}
}

for _, check in ipairs(key_checks) do
  local mapping = vim.fn.maparg(check[1], check[2])
  if mapping ~= "" then
    print("✅ " .. check[1] .. " (" .. check[3] .. ")")
  else
    print("❌ " .. check[1] .. " (" .. check[3] .. ") が設定されていません")
  end
end

-- === ファイル構造確認 ===
print("\n📁 ファイル構造:")

local config_dir = vim.fn.stdpath('config')
local important_files = {
  -- 基本設定ファイル
  'init.lua',
  'lua/config/options.lua',
  'lua/config/keymaps.lua',
  'lua/config/lazy.lua',
  -- 新しいディレクトリ構造の主要プラグイン
  'lua/plugins/ui/tokyonight.lua',
  'lua/plugins/move/neo-tree.lua',
  'lua/plugins/move/telescope.lua',
  'lua/plugins/code/treesitter.lua',
  'lua/plugins/code/lspconfig.lua',
  'lua/plugins/tool/which-key.lua',
  'lua/plugins/code/blink-cmp.lua',
  'lua/plugins/tool/gitsigns.lua',
  'lua/plugins/code/trouble.lua'
}

for _, file in ipairs(important_files) do
  local filepath = config_dir .. '/' .. file
  if vim.fn.filereadable(filepath) == 1 then
    print("✅ " .. file)
  else
    print("❌ " .. file .. " が見つかりません")
  end
end

print("\n📝 リファクタリング前の状態確認完了")
print("📋 この状態を基準にリファクタリングを進めます")

vim.cmd('qa!')
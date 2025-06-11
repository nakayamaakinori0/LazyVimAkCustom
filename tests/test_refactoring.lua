-- リファクタリング用テスト
-- プラグインファイル分離前後で機能が正常に動作することを確認

-- 設定読み込み
if not vim.g.mapleader then
  local config_path = vim.fn.stdpath('config')
  dofile(config_path .. '/init.lua')
end

local function assert_true(condition, message)
  if not condition then
    error(message or "テスト失敗")
  end
end

local function test_plugin_available(plugin_name, description)
  local ok, _ = pcall(require, plugin_name)
  assert_true(ok, string.format("%s (%s) が利用できません", plugin_name, description))
  print("✅ " .. plugin_name .. " (" .. description .. ")")
end

local function test_keymap_exists(mode, key, description)
  local mapping = vim.fn.maparg(key, mode)
  assert_true(mapping ~= "", string.format("%s (%s) キーマップが存在しません", key, description))
  print("✅ " .. key .. " (" .. description .. ")")
end

-- === リファクタリング対象プラグインのテスト ===
print("🧪 リファクタリング対象プラグインの動作確認...")

-- 1. LSP関連プラグイン（lazy loadingを考慮）
print("\n📋 LSP関連プラグイン:")
local lazy = require('lazy')
local plugins = lazy.plugins()

-- プラグインが設定されているかチェック
local function test_plugin_configured(plugin_pattern, description)
  local found = false
  for name, plugin in pairs(plugins) do
    if name:find(plugin_pattern) or (plugin[1] and plugin[1]:find(plugin_pattern)) then
      found = true
      break
    end
  end
  assert_true(found, string.format("%s (%s) が設定されていません", plugin_pattern, description))
  print("✅ " .. plugin_pattern .. " (" .. description .. ") が設定済み")
end

-- 主要プラグインのリスト
local expected_plugins = {
  "lspconfig",
  "mason", 
  "blink",
  "treesitter",
  "telescope",
  "neo%-tree",
  "which%-key",
  "trouble",
  "gitsigns",
  "noice",
  "dashboard"
}

local found_plugins = {}
for name, plugin in pairs(plugins) do
  for _, pattern in ipairs(expected_plugins) do
    if name:find(pattern) or (plugin[1] and plugin[1]:find(pattern)) then
      found_plugins[pattern] = true
      print("✅ " .. pattern .. " プラグインが設定済み")
      break
    end
  end
end

-- 見つからなかったプラグインをレポート
for _, pattern in ipairs(expected_plugins) do
  if not found_plugins[pattern] then
    print("⚠️  " .. pattern .. " プラグインが見つかりません")
  end
end

-- === 重要なキーマップのテスト ===
print("\n⌨️  重要なキーマップ:")

-- ファイル操作
test_keymap_exists("n", "<leader>ff", "ファイル検索")
test_keymap_exists("n", "<leader>e", "ファイルエクスプローラー")

-- LSP
test_keymap_exists("n", "gd", "定義ジャンプ")
test_keymap_exists("n", "gr", "参照一覧")

-- Git
test_keymap_exists("n", "<leader>gd", "Git diff")

-- === プラグインファイル存在確認 ===
print("\n📂 プラグインファイル構造:")

local plugins_dir = vim.fn.stdpath('config') .. '/lua/plugins'
local required_files = {
  'core.lua',
  'coding.lua', 
  'ui.lua',
  'conform.lua',
  'avante.lua',
  'telekasten.lua'
}

for _, file in ipairs(required_files) do
  local filepath = plugins_dir .. '/' .. file
  local exists = vim.fn.filereadable(filepath) == 1
  assert_true(exists, string.format("プラグインファイル %s が存在しません", file))
  print("✅ " .. file .. " が存在")
end

-- === lazy.nvim設定確認 ===
print("\n⚡ lazy.nvim設定:")

local plugin_count = 0
for _, _ in pairs(plugins) do
  plugin_count = plugin_count + 1
end

assert_true(plugin_count > 20, "プラグイン数が少なすぎます: " .. plugin_count)
print("✅ プラグイン総数: " .. plugin_count)

-- === カラースキーム確認 ===
print("\n🌈 カラースキーム:")
local colorscheme = vim.g.colors_name or "デフォルト"
print("✅ 現在のカラースキーム: " .. colorscheme)

print("\n🎉 リファクタリング前の機能確認完了!")
print("📝 この結果を基準にリファクタリング後のテストを行います")

vim.cmd('qa!')
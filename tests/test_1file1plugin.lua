-- 1file1plugin構成の確認テスト
-- 各プラグインファイルが1つのプラグインのみを含むことを確認

-- 設定読み込み
if not vim.g.mapleader then
  local config_path = vim.fn.stdpath('config')
  dofile(config_path .. '/init.lua')
end

print("🧪 1file1plugin構成確認テスト...")

local plugins_dir = vim.fn.stdpath('config') .. '/lua/plugins'
local files = vim.fn.glob(plugins_dir .. '/*.lua', 0, 1)

print(string.format("\n📂 プラグインディレクトリ: %s", plugins_dir))
print(string.format("📄 Luaファイル数: %d", #files))

-- 特別なファイル（空ファイルまたは複数プラグインを含む可能性のあるファイル）
local special_files = {
  'core.lua',      -- 空ファイル（非推奨）
  'coding.lua',    -- 空ファイル（非推奨）
  'ui.lua',        -- 空ファイル（非推奨）
  'disable.lua',   -- プラグイン無効化用
  'example.lua',   -- サンプル（無効化済み）
}

local function is_special_file(filename)
  for _, special in ipairs(special_files) do
    if filename == special then
      return true
    end
  end
  return false
end

print("\n🔍 各ファイルの内容確認:")

local single_plugin_files = 0
local empty_or_special_files = 0
local multi_plugin_files = 0

for _, filepath in ipairs(files) do
  local filename = vim.fn.fnamemodify(filepath, ':t')
  
  if is_special_file(filename) then
    print(string.format("⚪ %s (特別ファイル)", filename))
    empty_or_special_files = empty_or_special_files + 1
  else
    -- ファイル内容を読み取りプラグイン数をカウント
    local content = vim.fn.readfile(filepath)
    local content_str = table.concat(content, "\n")
    
    -- プラグイン定義パターンをカウント
    local plugin_count = 0
    -- "github-user/repo-name" パターンを検索
    for match in content_str:gmatch('"[%w%-_]+/[%w%-_.]+[%w%-_]+"') do
      plugin_count = plugin_count + 1
    end
    
    if plugin_count == 0 then
      print(string.format("⚪ %s (プラグインなし)", filename))
      empty_or_special_files = empty_or_special_files + 1
    elseif plugin_count == 1 then
      print(string.format("✅ %s (1プラグイン)", filename))
      single_plugin_files = single_plugin_files + 1
    else
      print(string.format("⚠️  %s (%dプラグイン)", filename, plugin_count))
      multi_plugin_files = multi_plugin_files + 1
    end
  end
end

print("\n📊 統計:")
print(string.format("✅ 1プラグインファイル: %d", single_plugin_files))
print(string.format("⚪ 空/特別ファイル: %d", empty_or_special_files))
print(string.format("⚠️  複数プラグインファイル: %d", multi_plugin_files))

-- プラグイン総数確認
local lazy = require('lazy')
local plugins = lazy.plugins()
local plugin_count = 0
for _, _ in pairs(plugins) do
  plugin_count = plugin_count + 1
end

print(string.format("\n📦 総プラグイン数: %d", plugin_count))

-- 結果判定
if multi_plugin_files == 0 then
  print("\n🎉 1file1plugin構成が正常に実装されています！")
  print("各プラグインは個別ファイルに適切に分離されています。")
else
  print(string.format("\n❌ %d個のファイルが複数プラグインを含んでいます", multi_plugin_files))
end

print("\n📋 1file1plugin構成確認完了")

vim.cmd('qa!')
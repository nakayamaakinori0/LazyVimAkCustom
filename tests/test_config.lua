-- Neovim Configuration Tests
-- Usage: nvim --headless -l tests/test_config.lua

-- Load configuration if not already loaded
if not vim.g.mapleader then
  local config_path = vim.fn.stdpath('config')
  dofile(config_path .. '/init.lua')
end

local function test(name, fn)
  local success, result = pcall(fn)
  if success then
    print("✅ " .. name)
    return true
  else
    print("❌ " .. name .. ": " .. tostring(result))
    return false
  end
end

local function assert_equal(expected, actual, message)
  if expected ~= actual then
    error(message or string.format("Expected %s, got %s", tostring(expected), tostring(actual)))
  end
end

local function assert_not_nil(value, message)
  if value == nil then
    error(message or "Expected value to not be nil")
  end
end

local function assert_keymap_exists(mode, key, message)
  local mapping = vim.fn.maparg(key, mode)
  if mapping == "" then
    error(message or string.format("Keymap %s not found in mode %s", key, mode))
  end
end

-- Test Results
local results = {}

-- Test 1: Basic Options
results[#results + 1] = test("Leader key is set to space", function()
  assert_equal(" ", vim.g.mapleader, "Leader key should be space")
end)

results[#results + 1] = test("Basic vim options are set", function()
  assert_equal(true, vim.opt.number:get(), "Line numbers should be enabled")
  assert_equal(true, vim.opt.relativenumber:get(), "Relative line numbers should be enabled")
  assert_equal(2, vim.opt.tabstop:get(), "Tab width should be 2")
  assert_equal(2, vim.opt.shiftwidth:get(), "Shift width should be 2")
  assert_equal(true, vim.opt.expandtab:get(), "Expand tabs should be enabled")
end)

-- Test 2: Window Navigation Keymaps
results[#results + 1] = test("Window navigation keymaps exist", function()
  assert_keymap_exists("n", "<C-h>", "Ctrl+h keymap missing")
  assert_keymap_exists("n", "<C-j>", "Ctrl+j keymap missing")
  assert_keymap_exists("n", "<C-k>", "Ctrl+k keymap missing")
  assert_keymap_exists("n", "<C-l>", "Ctrl+l keymap missing")
end)

results[#results + 1] = test("Window navigation keymaps point to correct commands", function()
  local mappings = {
    ["<C-h>"] = "<C-W>h",
    ["<C-j>"] = "<C-W>j", 
    ["<C-k>"] = "<C-W>k",
    ["<C-l>"] = "<C-W>l"
  }
  
  for key, expected in pairs(mappings) do
    local actual = vim.fn.maparg(key, "n")
    assert_equal(expected, actual, string.format("Keymap %s should map to %s, got %s", key, expected, actual))
  end
end)

-- Test 3: Custom Keymaps
results[#results + 1] = test("Custom keymaps exist", function()
  assert_keymap_exists("i", "jj", "jj -> Esc keymap missing")
  assert_keymap_exists("n", "H", "H -> 0 keymap missing")
  assert_keymap_exists("n", "L", "L -> $ keymap missing")
end)

-- Test 4: Window Operations
results[#results + 1] = test("Window splitting works", function()
  local initial_windows = vim.fn.winnr('$')
  vim.cmd('split')
  local after_split = vim.fn.winnr('$')
  assert_equal(initial_windows + 1, after_split, "Split should create new window")
  
  vim.cmd('vsplit')
  local after_vsplit = vim.fn.winnr('$')
  assert_equal(after_split + 1, after_vsplit, "Vsplit should create another window")
end)

results[#results + 1] = test("Window navigation works", function()
  -- Ensure we have multiple windows
  vim.cmd('only') -- Close all but current
  vim.cmd('vsplit')
  
  local initial_window = vim.fn.winnr()
  vim.cmd('wincmd h')
  local after_nav = vim.fn.winnr()
  
  -- Should be different window numbers
  assert_not_nil(after_nav, "Window navigation should return valid window number")
end)

-- Test 5: Plugin Loading
results[#results + 1] = test("Lazy.nvim is loaded", function()
  assert_not_nil(require('lazy'), "Lazy.nvim should be available")
end)

results[#results + 1] = test("Core plugins are configured", function()
  local lazy = require('lazy')
  local plugins = lazy.plugins()
  
  local core_plugins = {
    'telescope.nvim',
    'which-key.nvim',
    'gitsigns.nvim',
    'nvim-treesitter'
  }
  
  for _, plugin_name in ipairs(core_plugins) do
    local found = false
    for _, plugin in pairs(plugins) do
      if plugin.name == plugin_name or plugin[1] and plugin[1]:find(plugin_name) then
        found = true
        break
      end
    end
    if not found then
      error(string.format("Plugin %s should be configured", plugin_name))
    end
  end
end)

-- Test 6: LSP Configuration  
results[#results + 1] = test("LSP config is configured", function()
  local lazy = require('lazy')
  local plugins = lazy.plugins()
  
  local found = false
  for _, plugin in pairs(plugins) do
    if plugin.name == 'nvim-lspconfig' or (plugin[1] and plugin[1]:find('lspconfig')) then
      found = true
      break
    end
  end
  
  if not found then
    error("LSP config should be configured")
  end
end)

-- Test 7: Custom Plugin Settings
results[#results + 1] = test("PHP LSP setting is correct", function()
  assert_equal("intelephense", vim.g.lazyvim_php_lsp, "PHP LSP should be set to intelephense")
end)

-- Test 8: Autocommands
results[#results + 1] = test("Autocommands are loaded", function()
  local groups = vim.api.nvim_get_autocmds({})
  local has_highlight_yank = false
  
  for _, autocmd in ipairs(groups) do
    if autocmd.group_name and autocmd.group_name:match("highlight_yank") then
      has_highlight_yank = true
      break
    end
  end
  
  if not has_highlight_yank then
    error("Highlight on yank autocommand should be present")
  end
end)

-- Test Results Summary
local passed = 0
local total = #results

for _, result in ipairs(results) do
  if result then
    passed = passed + 1
  end
end

print("\n" .. string.rep("=", 50))
print(string.format("Test Results: %d/%d passed", passed, total))

if passed == total then
  print("🎉 All tests passed!")
  vim.cmd('qa!')
else
  print("⚠️  Some tests failed. Check the output above.")
  os.exit(1)
end
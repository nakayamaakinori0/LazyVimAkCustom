-- Minimal Configuration Test
-- Quick smoke test for essential functionality

-- Load configuration if not already loaded
if not vim.g.mapleader then
  -- Load configuration manually when run as script
  local config_path = vim.fn.stdpath('config')
  dofile(config_path .. '/init.lua')
end

local function assert_true(condition, message)
  if not condition then
    error(message or "Assertion failed")
  end
end

-- Test 1: Essential keymaps
local essential_keymaps = {
  {mode = "n", key = "<C-h>", desc = "window left"},
  {mode = "n", key = "<C-j>", desc = "window down"}, 
  {mode = "n", key = "<C-k>", desc = "window up"},
  {mode = "n", key = "<C-l>", desc = "window right"},
  {mode = "i", key = "jj", desc = "escape"},
}

print("🧪 Testing essential keymaps...")
for _, keymap in ipairs(essential_keymaps) do
  local mapping = vim.fn.maparg(keymap.key, keymap.mode)
  assert_true(mapping ~= "", string.format("%s keymap missing (%s)", keymap.key, keymap.desc))
  print("✅ " .. keymap.key .. " (" .. keymap.desc .. ")")
end

-- Test 2: Basic options
print("\n🧪 Testing basic options...")
assert_true(vim.g.mapleader == " ", "Leader key should be space")
print("✅ Leader key")

assert_true(vim.opt.number:get(), "Line numbers should be enabled")
print("✅ Line numbers")

assert_true(vim.opt.expandtab:get(), "Expand tabs should be enabled")
print("✅ Expand tabs")

-- Test 3: Plugin manager
print("\n🧪 Testing plugin manager...")
local lazy_ok, lazy = pcall(require, 'lazy')
assert_true(lazy_ok, "Lazy.nvim should be available")
print("✅ Lazy.nvim loaded")

-- Test 4: Window operations
print("\n🧪 Testing window operations...")
local initial_windows = vim.fn.winnr('$')
vim.cmd('split')
assert_true(vim.fn.winnr('$') == initial_windows + 1, "Split should create new window")
print("✅ Window splitting")

vim.cmd('only') -- Clean up
print("✅ Window cleanup")

print("\n🎉 All minimal tests passed!")
vim.cmd('qa!')
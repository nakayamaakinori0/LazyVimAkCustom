-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<leader>r", ":source $MYVIMRC")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")
vim.keymap.del("n", "H")
vim.keymap.del("n", "L")
vim.keymap.set("n", "H", "0")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "0")
vim.keymap.set("v", "L", "$")
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<A-h>", ":BufferLineMovePrev<CR>")
vim.keymap.set("n", "<A-l>", ":BufferLineMoveNext<CR>")
vim.keymap.set("n", "<leader>tk", ":Telekasten panel<CR>")
vim.keymap.set("n", "<leader>td", function()
  vim.cmd("normal! i" .. os.date("%Y-%m-%d"))
end, { desc = "Insert current date (YYYY-MM-DD)" })
vim.keymap.set("n", "<leader>ws", ":split<CR>")
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>gd", function()
  local diffview = require("diffview.lib")
  if diffview.get_current_view() then
    vim.cmd("DiffviewClose")
  else
    vim.cmd("DiffviewOpen")
  end
end, { desc = "Toggle Diffview" })

vim.keymap.set("n", "<leader>fp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end, { desc = "Copy relative file path" })

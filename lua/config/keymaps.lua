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
vim.keymap.set("n", "<A-Left>", ":BufferLineMovePrev<CR>")
vim.keymap.set("n", "<A-Right>", ":BufferLineMoveNext<CR>")
vim.keymap.set("n", "<leader>tk", ":Telekasten panel<CR>")
vim.keymap.set("n", "<leader>td", function()
  vim.cmd("normal! i" .. os.date("%Y-%m-%d"))
end, { desc = "Insert current date (YYYY-MM-DD)" })
-- vim.keymap.set("n", "<leader>p", ":echo expand("%:p")

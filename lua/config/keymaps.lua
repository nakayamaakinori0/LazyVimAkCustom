local function map(mode, after, before, desc)
  desc = desc or {}
  desc.silent = desc.silent ~= false
  vim.keymap.set(mode, after, before, desc)
end

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffers
map("n", "<leader>bl", ":Neotree buffers<CR>", { desc = "List Buffers" })
map("n", "<leader>bD", ":% bd<CR>")

-- file explorer
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Explorer Toggle" })
map("n", "<leader>E", ":Neotree reveal<CR>", { desc = "Explorer Toggle current file" })

-- Range indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Location list
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- Diagnostic keymaps
-- map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>ws", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })

-- Custom keymaps
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")
vim.keymap.set("n", "H", "0")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "0")
vim.keymap.set("v", "L", "$")

vim.keymap.set("n", "<leader>tk", ":Telekasten panel<CR>")

vim.keymap.set("n", "<leader>td", function()
  vim.cmd("normal! i" .. os.date("%Y-%m-%d"))
end, { desc = "Insert current date (YYYY-MM-DD)" })

vim.keymap.set("n", "<leader>gd", function()
  local diffview = require("diffview.lib")
  if diffview.get_current_view() then
    vim.cmd("DiffviewClose")
  else
    vim.cmd("DiffviewOpen")
  end
end, { desc = "Toggle Diffview" })

vim.keymap.set("n", "<leader>fy", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<leader>fY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end, { desc = "Copy absolute file path" })

vim.keymap.set("n", "<leader>cc", "gcc", { desc = "Toggle comment on current line", remap = true })

vim.keymap.set("n", "<leader>q", ":q<CR>")

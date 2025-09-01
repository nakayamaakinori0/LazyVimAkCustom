return {
  "preservim/nerdtree",
  enabled = true,
  dependencies = { "Xuyuanp/nerdtree-git-plugin", "ryanoasis/vim-devicons" },
  config = function()
    vim.api.nvim_set_keymap("n", "<leader>e", ":NERDTreeToggle<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>E", ":NERDTreeFind<CR>", { noremap = true, silent = true })
    vim.g.NERDTreeShowHidden = 1
    vim.g.NERDTreeMinimalUI = 1
    vim.g.NERDTreeDirArrows = 1
    vim.g.NERDTreeGitStatusUseNerdFonts = 1
  end,
}

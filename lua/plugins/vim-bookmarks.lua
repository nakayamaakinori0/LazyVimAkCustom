return {
  {
    "MattesGroeger/vim-bookmarks",
    dependencies = { "tom-anders/telescope-vim-bookmarks.nvim" }, -- Telescopeで連携する場合
    config = function()
      vim.g.bookmark_save_per_working_dir = 1
      vim.g.bookmark_auto_save = 1
      vim.keymap.set("n", "<leader>mm", "<cmd>BookmarkToggle<cr>", { desc = "BookmarkToggle" })
      vim.keymap.set("n", "<leader>mi", "<cmd>BookmarkAnnotate<cr>", { desc = "BookmarkAnnotate" })
      vim.keymap.set("n", "<leader>ml", "<cmd>BookmarkShowAll<cr>", { desc = "BookmarkShowAll" })
    end,
  },
}

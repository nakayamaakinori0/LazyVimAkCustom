return {
  {
    "MattesGroeger/vim-bookmarks",
    dependencies = { "tom-anders/telescope-vim-bookmarks.nvim" }, -- Telescopeで連携する場合
    config = function()
      vim.g.bookmark_save_per_working_dir = 1
      vim.g.bookmark_auto_save = 1
    end,
  },
}

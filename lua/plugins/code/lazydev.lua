-- Lua開発支援: lazydev.nvim
-- Neovim Lua API の補完とドキュメント
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
}
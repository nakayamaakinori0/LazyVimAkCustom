-- インデントガイド: indent-blankline.nvim
-- インデントの可視化
return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = true,
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",                                 -- インデント文字
      tab_char = "│",                             -- タブ文字
    },
    scope = { enabled = false },                  -- スコープハイライトは無効
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
}

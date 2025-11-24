-- ステータスライン: lualine.nvim
-- 下部のステータスバー表示
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "tokyonight",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
    },
    sections = {
      lualine_c = {
        {
          "filename",
          path = 1, -- 0: ファイル名のみ, 1: 相対パス, 2: 絶対パス, 3: 絶対パス（~省略）, 4: 親ディレクトリ+ファイル名
        },
      },
    },
  },
}

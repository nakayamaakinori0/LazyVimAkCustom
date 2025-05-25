return {
  {
    "sindrets/diffview.nvim",
    -- tab, s-tabで次のファイルにいくdiffviewのdefault keymapを無効にしようとしたがうまくいかなかった（tab, s-tab自体が無効化されてしまう)
    --[[
    config = function()
      require("diffview").setup({
        keymaps = {
          file_panel = {
            ["<tab>"] = "<nop>",
            ["<s-tab>"] = "<nop>",
          },
          view = {
            ["<tab>"] = "<nop>",
            ["<s-tab>"] = "<nop>",
          },
        },
      })
    end,
    --]]
  },
}

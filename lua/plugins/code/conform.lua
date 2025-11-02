return {
  "stevearc/conform.nvim",
  lazy = true,
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format file",
    },
  },
  opts = {
    format_on_save = false,
    -- フォーマッターを追加する場合、masonでインストール後ここに追記する
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      fish = { "fish_indent" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      markdown = { "prettier" },
    },
  },
}

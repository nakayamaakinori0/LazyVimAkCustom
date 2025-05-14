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
  -- LazyVim の保存時自動フォーマットを無効化
  --[[
  init = function()
    vim.api.nvim_clear_autocmds({
      group = vim.api.nvim_create_augroup("LazyFormat", { clear = false }),
    })
  end,
  --]]
  opts = {
    format_on_save = false,

    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      fish = { "fish_indent" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
    },
  },
}

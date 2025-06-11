-- フォーマッター: none-ls.nvim
-- LSPを通じたフォーマット機能
return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        nls.builtins.formatting.stylua,           -- Luaフォーマッター
        nls.builtins.formatting.shfmt,            -- Shellフォーマッター
      },
    }
  end,
}
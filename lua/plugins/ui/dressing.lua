-- UI改善: dressing.nvim
-- vim.ui.select と vim.ui.input を美しく表示
return {
  "stevearc/dressing.nvim",
  lazy = true,
  init = function()
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
    vim.ui.input = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.input(...)
    end
  end,
}
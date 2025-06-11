-- アクティブインデント: mini.indentscope
-- 現在のインデントスコープをハイライト
return {
  "echasnovski/mini.indentscope",
  version = false,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    symbol = "│",                                 -- スコープ表示文字
    options = { try_as_border = true },           -- ボーダーとして表示を試行
  },
  init = function()
    -- 特定のファイルタイプでは無効化
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
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
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
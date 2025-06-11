-- Markdownプレビュー: peek.nvim
-- Deno使用、高速で軽量、Mermaidダイアグラム対応
return {
  "toppair/peek.nvim",
  enabled = true,
  event = { "VeryLazy" },
  ft = { "markdown" },
  build = "deno task --quiet build:fast",
  keys = {
    { "<leader>mp", function() require("peek").open() end, desc = "Peek Open" },
    { "<leader>mc", function() require("peek").close() end, desc = "Peek Close" },
  },
  config = function()
    require("peek").setup({
      auto_load = true,                          -- 自動読み込み
      close_on_bdelete = true,                   -- バッファ削除時に閉じる
      syntax = true,                             -- シンタックスハイライト
      theme = 'dark',                            -- ダークテーマ
      update_on_change = true,                   -- 変更時に自動更新
      app = 'webview',                           -- ブラウザで複数プレビュー可能
      filetype = { 'markdown' },                 -- ファイルタイプ
      throttle_at = 200000,                      -- スロットル設定
      throttle_time = 'auto',                    -- スロットル時間
    })
    
    -- コマンド作成
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
}

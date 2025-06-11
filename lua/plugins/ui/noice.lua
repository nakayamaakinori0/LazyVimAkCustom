-- UI改善: noice.nvim
-- メッセージ、コマンドライン、ポップアップメニューの改善
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },               -- ファイル情報メッセージ
            { find = "; after #%d+" },             -- 変更後メッセージ
            { find = "; before #%d+" },            -- 変更前メッセージ
          },
        },
        view = "mini",                             -- 小さい表示で
      },
    },
    presets = {
      bottom_search = true,                        -- 下部で検索
      command_palette = true,                      -- コマンドパレット風
      long_message_to_split = true,                -- 長いメッセージは分割
      inc_rename = true,                           -- リネーム時の表示改善
    },
  },
  keys = {
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
  },
}
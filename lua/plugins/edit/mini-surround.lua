-- サラウンド機能: mini.surround
-- テキストの囲み文字操作
return {
  "echasnovski/mini.surround",
  keys = function(_, keys)
    local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    local mappings = {
      { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
      { opts.mappings.delete, desc = "Delete surrounding" },
      { opts.mappings.find, desc = "Find right surrounding" },
      { opts.mappings.find_left, desc = "Find left surrounding" },
      { opts.mappings.highlight, desc = "Highlight surrounding" },
      { opts.mappings.replace, desc = "Replace surrounding" },
      { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
    }
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    mappings = {
      add = "gsa",                                 -- 囲み文字を追加
      delete = "gsd",                              -- 囲み文字を削除
      find = "gsf",                                -- 右側の囲み文字を検索
      find_left = "gsF",                           -- 左側の囲み文字を検索
      highlight = "gsh",                           -- 囲み文字をハイライト
      replace = "gsr",                             -- 囲み文字を置換
      update_n_lines = "gsn",                      -- n_lines設定を更新
    },
  },
}
-- 単語ハイライト: vim-illuminate
-- カーソル下の単語をハイライト表示
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 200,                                   -- ハイライト遅延時間
    large_file_cutoff = 2000,                      -- 大きなファイルでは無効化
    large_file_overrides = {
      providers = { "lsp" },                       -- 大きなファイルではLSPのみ使用
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)

    local function map(key, dir, buffer)
      vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
      end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end

    -- 基本的な移動マッピング
    map("]]", "next")
    map("[[", "prev")

    -- ファイルタイプごとのマッピング設定
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local buffer = vim.api.nvim_get_current_buf()
        map("]]", "next", buffer)
        map("[[", "prev", buffer)
      end,
    })
  end,
  keys = {
    { "]]", desc = "Next Reference" },
    { "[[", desc = "Prev Reference" },
  },
}
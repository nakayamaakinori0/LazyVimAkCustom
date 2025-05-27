return {
  {
    "mason-org/mason.nvim",
    version = "^1.0.0", -- 2.0.0で破壊的変更が入ったため,v1.x に固定
    --[[
    opts = function(_, opts)
      -- phpcs を除外する
      opts.ensure_installed = vim.tbl_filter(function(name)
        return name ~= "phpcs"
      end, opts.ensure_installed or {})
    end,
    --]]
  },
}

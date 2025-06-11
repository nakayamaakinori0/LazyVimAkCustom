-- リンター: nvim-lint
-- 各言語のリンティング機能
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      fish = { "fish" },                           -- fish shellリンター
    },
    linters = {},
  },
  config = function(_, opts)
    local M = {}

    local lint = require("lint")
    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
      else
        lint.linters[name] = linter
      end
    end
    lint.linters_by_ft = opts.linters_by_ft

    -- デバウンス機能（連続実行を防ぐ）
    function M.debounce(ms, fn)
      local timer = vim.uv.new_timer()
      return function(...)
        local argv = { ... }
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    -- リンティング実行
    function M.lint()
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)

      if #names == 0 then
        return
      end

      vim.list_extend(names, lint.linters_by_ft["_"] or {})

      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then
          vim.notify("Linter not found: " .. name, vim.log.levels.WARN, { title = "nvim-lint" })
        end
        return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
      end, names)

      if #names > 0 then
        lint.try_lint(names)
      end
    end

    -- 自動実行設定
    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = M.debounce(100, M.lint),
    })
  end,
}
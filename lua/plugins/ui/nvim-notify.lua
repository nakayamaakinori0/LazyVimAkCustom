-- 通知システム: nvim-notify
-- より美しい通知表示
return {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  opts = {
    timeout = 3000,                               -- 通知表示時間
    max_height = function()
      return math.floor(vim.o.lines * 0.75)      -- 最大高さ
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)    -- 最大幅
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })  -- 最前面に表示
    end,
  },
  init = function()
    local Util = require("lazy.core.util")
    local banned_messages = { "No information available" }
    vim.notify = function(msg, ...)
      for _, banned in ipairs(banned_messages) do
        if msg == banned then
          return
        end
      end
      return require("notify")(msg, ...)
    end
  end,
}
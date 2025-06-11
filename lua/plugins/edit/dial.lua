-- 数値増減拡張: dial.nvim
-- Ctrl+a/Ctrl+xで様々な値を増減
return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,               -- 10進数
        augend.integer.alias.hex,                   -- 16進数
        augend.date.alias["%Y/%m/%d"],             -- 日付
        augend.constant.alias.bool,                 -- true/false
        augend.semver.alias.semver,                -- セマンティックバージョン
      },
    })
  end,
}
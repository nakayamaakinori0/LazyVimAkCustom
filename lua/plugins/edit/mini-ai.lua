-- テキストオブジェクト拡張: mini.ai
-- より多様なテキストオブジェクトを提供
return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  opts = function()
    local ai = require("mini.ai")
    return {
      n_lines = 500,
      custom_textobjects = {
        -- ブロック、条件文、ループ
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        -- 関数
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        -- クラス
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        -- HTMLタグ
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^<>]->$" },
      },
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)
    
    -- which-key用の説明設定
    local i = {
      [" "] = "Whitespace",
      ['"'] = 'Balanced "',
      ["'"] = "Balanced '",
      ["`"] = "Balanced `",
      ["("] = "Balanced (",
      [")"] = "Balanced ) including white-space",
      [">"] = "Balanced > including white-space",
      ["<lt>"] = "Balanced <",
      ["]"] = "Balanced ] including white-space",
      ["["] = "Balanced [",
      ["}"] = "Balanced } including white-space",
      ["{"] = "Balanced {",
      ["?"] = "User Prompt",
      _ = "Underscore",
      a = "Argument",
      b = "Balanced ), ], }",
      c = "Class",
      f = "Function",
      o = "Block, conditional, loop",
      q = "Quote `, \", '",
      t = "Tag",
    }
    local a = vim.deepcopy(i)
    for k, v in pairs(a) do
      a[k] = v:gsub(" including.*", "")
    end
  end,
}
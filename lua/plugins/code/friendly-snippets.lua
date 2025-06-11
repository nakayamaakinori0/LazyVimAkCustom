-- スニペット集: friendly-snippets
-- VSCodeスタイルのスニペット集
return {
  "rafamadriz/friendly-snippets",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
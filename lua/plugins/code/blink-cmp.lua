-- 補完エンジン: Blink.cmp
-- 高速な補完とスニペット統合
return {
  "saghen/blink.cmp",
  lazy = false,
  version = "v0.*",
  opts = {
    keymap = {
      preset = "default",
      ["<C-y>"] = { "select_and_accept" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
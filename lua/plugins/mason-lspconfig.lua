return {
  {
    "mason-org/mason-lspconfig.nvim",
    version = "^1.0.0",               -- 2.0.0で破壊的変更が入ったため,v1.x に固定
    opts = {
      automatic_installation = false, -- 自動インストールを無効化
      ensure_installed = {},          -- 空にするか必要なもののみ指定
    },
  },
}

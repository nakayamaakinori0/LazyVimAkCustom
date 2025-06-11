return {
  {
    "mason-org/mason-lspconfig.nvim",
    version = "^1.0.0",               -- 2.0.0で破壊的変更が入ったため,v1.x に固定
    opts = {
      automatic_installation = false, -- 自動インストールを無効化
      ensure_installed = {
        "intelephense",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              format = {
                enable = false, -- フォーマット機能を無効化
              },
            },
          },
        },
      },
    },
  }
}

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- provider = "deepseek",
      -- vendors = {
      --   deepseek = {
      --     __inherited_from = "openai",
      --     api_key_name = "DEEPSEEK_API_KEY",
      --     endpoint = "https://api.deepseek.com",
      --     model = "deepseek-coder",
      --   },
      -- },
      provider = "gemini",
      gemini = {
        --https://ai.google.dev/gemini-api/docs/models/gemini
        model = "gemini-2.5-flash-preview-04-17",
        temperature = 0,
        max_tokens = 4096,
      },
      -- tab押した時、windowスイッチするデフォルトの挙動を無効化
      mappings = {
        --- @class AvanteConflictMappings
        sidebar = {
          switch_windows = "<Nop>",
          reverse_switch_windows = "<Nop>",
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- copilotのプラグインがうまくインストールできないので一旦コメントアウト
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      -- img-clipのプラグインがうまくインストールできないので一旦コメントアウト
      --[[
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      --]]
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}

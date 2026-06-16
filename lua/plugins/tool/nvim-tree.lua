return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    { "<localleader>ef", ":NvimTreeFindFile<CR>", desc = "Find current file in file explorer" },
  },
  lazy = false,
  opts = {
    hijack_directories = { -- if true, auto open with vi .
      enable = false,
      auto_open = false,
    },
    view = {
      width = 30,
    },
    sort = {
      sorter = function(nodes)
        table.sort(nodes, function(a, b)
          return a.name > b.name
        end)
      end,
    },
  },
}

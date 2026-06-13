return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    { "<localleader>ef", ":NvimTreeFindFile<CR>", desc = "Find current file in file explorer" },
  },
  opts = {
    view = {
      width = 30,
    },
  },
}

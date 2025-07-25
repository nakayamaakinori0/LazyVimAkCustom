return {
  "codetour",
  dir = vim.fn.stdpath("config") .. "/lua/custom/codetour",
  lazy = true,
  cmd = { "TourNext", "TourPrev", "TourLoad" },
  keys = {
    { "<leader>tn", "<cmd>TourNext<cr>", desc = "Next tour step" },
    { "<leader>tp", "<cmd>TourPrev<cr>", desc = "Previous tour step" },
  },
  config = function()
    require("custom.codetour").setup()
  end,
}

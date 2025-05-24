return {
  "simeji/winresizer",
  keys = {
    { "<C-w>", "<cmd>WinResizerStartResize<cr>", desc = "Start window resize mode" },
  },
  config = function()
    -- winresizerの設定
    vim.g.winresizer_start_key = "<C-w>"
    vim.g.winresizer_vert_resize = 5
    vim.g.winresizer_horiz_resize = 3
    vim.g.winresizer_finish_with_escape = 1
  end,
}

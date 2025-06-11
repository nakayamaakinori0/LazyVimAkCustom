return {
  "simeji/winresizer",

  keys = {
    { "<C-w>", "<cmd>WinResizerStartResize<cr>", desc = "Start window resize mode" },
  },

  enabled = false,

  config = function()
    -- ウィンドウサイズ変更の設定
    vim.g.winresizer_vert_resize = 5  -- 垂直方向
    vim.g.winresizer_horiz_resize = 3 -- 水平方向
    vim.g.winresizer_finish_with_escape = 1

    -- デフォルトキーマップがinitで作成されてしまうので、configで削除する
    vim.api.nvim_del_keymap('n', '<C-e>')
  end,
}

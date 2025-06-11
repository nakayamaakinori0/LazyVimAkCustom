-- スニペット: LuaSnip
-- コードスニペット機能
return {
  "L3MON4D3/LuaSnip",
  lazy = true,
  build = (not jit.os:find("Windows"))
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
    or nil,
  dependencies = { "friendly-snippets" },        -- 外部ファイルの依存関係参照
  opts = {
    history = true,                                -- スニペット履歴を保持
    delete_check_events = "TextChanged",           -- テキスト変更時にスニペットを削除
  },
}
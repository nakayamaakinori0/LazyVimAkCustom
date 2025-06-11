return {
  {
    "preservim/vim-markdown",
    ft = "markdown",
    dependencies = {
      "godlygeek/tabular", -- Required for table formatting
    },
    config = function()
      -- Disable folding
      vim.g.vim_markdown_folding_disabled = 1

      -- Enable math syntax highlighting
      vim.g.vim_markdown_math = 1

      -- Enable frontmatter syntax highlighting
      vim.g.vim_markdown_frontmatter = 1

      -- Enable TOML frontmatter
      vim.g.vim_markdown_toml_frontmatter = 1

      -- Enable JSON frontmatter
      vim.g.vim_markdown_json_frontmatter = 1

      -- Enable strikethrough
      vim.g.vim_markdown_strikethrough = 1

      -- Follow named anchors
      vim.g.vim_markdown_follow_anchor = 1

      -- Auto-insert bullets
      vim.g.vim_markdown_auto_insert_bullets = 1

      -- New list item indent
      vim.g.vim_markdown_new_list_item_indent = 2
    end,
  },
}

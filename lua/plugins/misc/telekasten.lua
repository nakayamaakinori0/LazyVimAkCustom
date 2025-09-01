-- telekasten settings
local base_path = "~/dev/telekasten"

-- vault設定を生成する関数
local function create_vault(name)
  local vault_path = vim.fn.expand(base_path .. "/" .. name)
  return {
    home = vault_path,
    dailies = vault_path .. "/daily",
    weeklies = vault_path .. "/weekly",
    templates = vault_path .. "/templates",
    template_new_note = vault_path .. "/templates/default.md",
    template_new_daily = vault_path .. "/templates/daily.md",
    template_new_weekly = vault_path .. "/templates/weekly.md",
  }
end

-- vault定義
local vaults = {
  private = create_vault("private"),
  work = create_vault("work"),
}

-- デフォルトvault
local default_vault = vaults.work

return {
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = vim.tbl_extend("force", default_vault, {
      vaults = vaults,
      auto_set_filetype = false,
      filetype = "markdown",
    }),
  },
}

-- telekasten settings
--[[
local private_home = vim.fn.expand("~/dev/telekasten/private")
local work_home = vim.fn.expand("~/dev/telekasten/work")

local daily_private = vim.fn.expand("~/dev/telekasten/private/daily")
local weekly_private = vim.fn.expand("~/dev/telekasten/private/weekly")

local daily_work = vim.fn.expand("~/dev/telekasten/work/daily")
local weekly_work = vim.fn.expand("~/dev/telekasten/work/weekly")

local templates_private = vim.fn.expand("~/dev/telekasten/private/templates")
local template_new_note_private = vim.fn.expand("~/dev/telekasten/private/templates/default.md")
local template_new_daily_private = vim.fn.expand("~/dev/telekasten/private/templates/daily.md")
local template_new_weekly_private = vim.fn.expand("~/dev/telekasten/private/templates/weekly.md")

local templates_work = vim.fn.expand("~/dev/telekasten/work/templates")
local template_new_note_work = vim.fn.expand("~/dev/telekasten/work/templates/default.md")
local template_new_daily_work = vim.fn.expand("~/dev/telekasten/work/templates/daily.md")
local template_new_weekly_work = vim.fn.expand("~/dev/telekasten/work/templates/weekly.md")

local private = {
  home = private_home,
  dailies = daily_private,
  weeklies = weekly_private,
  templates = templates_private,
  template_new_note = template_new_note_private,
  template_new_daily = template_new_daily_private,
  template_new_weekly = template_new_weekly_private,
}

local work = {
  home = work_home,
  dailies = daily_work,
  weeklies = weekly_work,
  templates = templates_work,
  template_new_note = template_new_note_work,
  template_new_daily = template_new_daily_work,
  template_new_weekly = template_new_weekly_work,
}

local vaults = {
  work = work,
  private = private,
}
]]

local home = vim.fn.expand("~/dev/telekasten")
local daily = vim.fn.expand("~/dev/telekasten/daily")
local weekly = vim.fn.expand("~/dev/telekasten/weekly")
local templates = vim.fn.expand("~/dev/telekasten/templates")
local template_default = vim.fn.expand("~/dev/telekasten/templates/default.md")
local template_daily = vim.fn.expand("~/dev/telekasten/templates/daily.md")
local template_weekly = vim.fn.expand("~/dev/telekasten/templates/weekly.md")

return {
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      home = home,
      dailies = daily,
      weeklies = weekly,
      templates = templates,
      template_new_note = template_default,
      template_new_daily = template_daily,
      template_new_weekly = template_weekly,
      -- vaults = vaults,

      auto_set_filetype = false,
      filetype = "markdown",
    },
  },
}

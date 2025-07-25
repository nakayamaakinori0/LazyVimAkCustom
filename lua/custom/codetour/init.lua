local M = {}
local state = {
  steps = {},
  current = 0,
}

local function jump_to_step(index)
  local step = state.steps[index]
  if not step then
    return
  end

  vim.cmd("edit " .. step.file)
  vim.api.nvim_win_set_cursor(0, { step.line, 0 })

  -- シンプルな通知
  vim.notify(string.format("[%d/%d] %s", index, #state.steps, step.text))
end

function M.next()
  if #state.steps == 0 then
    vim.notify("No tour loaded")
    return
  end

  state.current = state.current % #state.steps + 1
  jump_to_step(state.current)
end

function M.prev()
  if #state.steps == 0 then
    vim.notify("No tour loaded")
    return
  end

  state.current = state.current - 1
  if state.current < 1 then
    state.current = #state.steps
  end
  jump_to_step(state.current)
end

function M.load(name)
  local tour_file = ".vim-tours/" .. name .. ".json"
  local file = io.open(tour_file, "r")

  if not file then
    vim.notify("Tour not found: " .. name)
    return
  end

  local content = file:read("*all")
  file:close()

  local ok, data = pcall(vim.json.decode, content)
  if ok and data.steps then
    state.steps = data.steps
    state.current = 0
    vim.notify("Tour loaded: " .. name .. " (" .. #state.steps .. " steps)")
  else
    vim.notify("Invalid tour file")
  end
end

function M.setup()
  vim.api.nvim_create_user_command("TourNext", M.next, {})
  vim.api.nvim_create_user_command("TourPrev", M.prev, {})
  vim.api.nvim_create_user_command("TourLoad", function(opts)
    M.load(opts.args)
  end, {
    nargs = 1,
    complete = function()
      local files = vim.fn.glob(".vim-tours/*.json", false, true)
      local names = {}
      for _, file in ipairs(files) do
        table.insert(names, vim.fn.fnamemodify(file, ":t:r"))
      end
      return names
    end,
  })
end

return M

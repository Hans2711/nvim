local M = {}

local data_path = vim.fn.stdpath('data') .. '/recent_files.json'
local max_items = 100

local function load()
  local f = io.open(data_path, 'r')
  if not f then
    return {}
  end
  local ok, decoded = pcall(vim.fn.json_decode, f:read('*a'))
  f:close()
  if ok and type(decoded) == 'table' then
    return decoded
  end
  return {}
end

local function save(list)
  local f = io.open(data_path, 'w')
  if not f then
    return
  end
  f:write(vim.fn.json_encode(list))
  f:close()
end

function M.update(filepath)
  local list = load()
  -- remove existing entry
  for i, item in ipairs(list) do
    if item.file == filepath then
      table.remove(list, i)
      break
    end
  end
  table.insert(list, 1, { file = filepath, time = os.time() })
  -- trim list
  while #list > max_items do
    table.remove(list)
  end
  save(list)
end

function M.open()
  local list = load()
  table.sort(list, function(a, b)
    return (a.time or 0) > (b.time or 0)
  end)

  local results = {}
  for _, item in ipairs(list) do
    table.insert(results, item.file)
  end

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  pickers.new({}, {
    prompt_title = 'Recent Files',
    finder = finders.new_table({ results = results }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection and selection[1] then
          vim.cmd('edit ' .. vim.fn.fnameescape(selection[1]))
        end
      end)
      return true
    end,
  }):find()
end

function M.setup()
  vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
      local file = vim.fn.expand('%:p')
      if file ~= '' then
        M.update(file)
      end
    end,
  })
end

return M

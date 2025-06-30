local M = {}

-- determine a project-scoped data path
local function get_data_path()
  -- use the current working directory as the project root
  local root = vim.fn.getcwd()
  -- take the last segment of the path as the project name
  local project = vim.fn.fnamemodify(root, ':t')
  -- build a directory under stdpath('data')/recent_files/<project>/
  local base = vim.fn.stdpath('data') .. '/recent_files/' .. project
  -- ensure it exists
  vim.fn.mkdir(base, 'p')
  -- file name inside that directory
  return base .. '/recent_files.json'
end

local max_items = 100

local function load()
  local path = get_data_path()
  local f = io.open(path, 'r')
  if not f then return {} end
  local ok, decoded = pcall(vim.fn.json_decode, f:read('*a'))
  f:close()
  if ok and type(decoded) == 'table' then
    return decoded
  end
  return {}
end

local function save(list)
  local path = get_data_path()
  local f = io.open(path, 'w')
  if not f then return end
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
  -- add to front
  table.insert(list, 1, { file = filepath, time = os.time() })
  -- trim
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
    prompt_title = 'Recent Files (project)',
    finder = finders.new_table({ results = results }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
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

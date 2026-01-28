local M = {}

-- determine a project-scoped data path
local function get_data_path()
  -- use the current working directory as the project root
  local root = vim.fn.getcwd()
  -- create a hash of the full path for uniqueness
  local hash = vim.fn.sha256(root):sub(1, 16)
  -- keep the project name for readability
  local project = vim.fn.fnamemodify(root, ':t')
  -- build a directory under stdpath('data')/recent_files/<hash>_<project>/
  local base = vim.fn.stdpath('data') .. '/recent_files/' .. hash .. '_' .. project
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
  local cwd = vim.fn.getcwd()
  
  -- Filter to only show files under current working directory (strict match)
  local filtered = {}
  for _, item in ipairs(list) do
    if vim.startswith(item.file, cwd .. '/') or item.file == cwd then
      table.insert(filtered, item)
    end
  end
  
  -- Sort by time
  table.sort(filtered, function(a, b)
    return (a.time or 0) > (b.time or 0)
  end)

  -- Prepare results with relative paths for display
  local cwd_display = cwd .. '/'
  local results = {}
  for _, item in ipairs(filtered) do
    -- Convert to relative path if under cwd
    local display_path = item.file
    if vim.startswith(item.file, cwd_display) then
      display_path = item.file:sub(#cwd_display + 1)
    end
    table.insert(results, display_path)
  end

  -- Use fzf-lua picker with preview
  require('fzf-lua').fzf_exec(results, {
    prompt = 'Recent Files (directory)> ',
    cwd = cwd,
    actions = {
      ['default'] = function(selected)
        if selected and selected[1] then
          -- Reconstruct absolute path if needed
          local file = selected[1]
          if not vim.startswith(file, '/') then
            file = cwd .. '/' .. file
          end
          vim.cmd('edit ' .. vim.fn.fnameescape(file))
        end
      end
    },
    winopts = {
      title = ' Recent Files (directory) ',
      title_pos = 'center',
      preview = {
        default = 'bat',
        layout = 'horizontal',
        vertical = 'down:50%',
      },
    },
    previewer = 'builtin',
  })
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

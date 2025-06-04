-- lua/dap-php-picker.lua  (or anywhere you source during init)

local dap = require('dap')
local uv  = vim.loop                -- libuv bindings inside Neovim
local widgets     = require('dap.ui.widgets')
local var_sidebar = widgets.sidebar(
  widgets.scopes,
  {},               -- opts (width/height only)
  'vertical botright split'     -- ← open-command: right-most vsplit
)

dap.adapters.php = {
  type    = 'executable',
  command = 'node',
  args    = { '/home/diesi/vscode-php-debug/out/phpDebug.js' },
}

---------------------------------------------------------------------------
-- 1. Scan /var/www/* for .env files and extract XDEBUG_CLIENT_PORT
---------------------------------------------------------------------------
local function collect_projects(base)
  local projects, dir = {}, uv.fs_scandir(base)
  if not dir then return projects end             -- nothing there

  while true do
    local entry, etype = uv.fs_scandir_next(dir)
    if not entry then break end                   -- finished iterating
    if etype == 'directory' then
      local env = string.format('%s/%s/.env', base, entry)
      local fh  = io.open(env, 'r')
      if fh then
        for line in fh:lines() do
          local port = line:match('^%s*XDEBUG_CLIENT_PORT%s*=%s*(%d+)%s*$')
          if port then
            table.insert(projects,
              { folder = entry, port = tonumber(port) })
            break
          end
        end
        fh:close()
      end
    end
  end
  table.sort(projects, function(a, b) return a.folder < b.folder end)
  return projects
end

---------------------------------------------------------------------------
-- 2. Ask the user which project/port to use, then run dap
---------------------------------------------------------------------------
local function choose_and_run()
  local list = collect_projects('/var/www')
  if #list == 0 then
    vim.notify('No .env with XDEBUG_CLIENT_PORT found under /var/www',
               vim.log.levels.ERROR)
    return
  end

  local labels = vim.tbl_map(
    function(p) return string.format('%s  ➜  %d', p.folder, p.port) end,
    list)

  vim.ui.select(labels, { prompt = 'Start Xdebug on which project/port?' },
    function(item)
      if not item then return end                -- user cancelled

      -- find the matching table entry
      local sel
      for i, label in ipairs(labels) do
        if label == item then sel = list[i]; break end
      end

      dap.run({
        type       = 'php',
        request    = 'launch',
        name       = ('Xdebug %s:%d'):format(sel.folder, sel.port),
        hostname   = '172.17.0.1',
        port       = sel.port,
        pathMappings = { ['/var/www/html'] = vim.fn.getcwd() },
      })
    end)
end

---------------------------------------------------------------------------
-- 3. Key-maps
---------------------------------------------------------------------------
vim.keymap.set('n', '<F5>',  choose_and_run,
  { desc = 'DAP: pick project/port & launch', noremap = true, silent = true })

vim.keymap.set('n', '<F8>',  function()
    dap.clear_breakpoints()
    dap.continue()
  end,
  { desc = 'DAP: continue (no more breaks)', noremap = true, silent = true })

vim.keymap.set('n', '<F9>',  dap.continue,
  { desc = 'DAP: continue to next breakpoint', noremap = true, silent = true })

vim.keymap.set('n', '<F10>', dap.step_over,
  { desc = 'DAP: step over', noremap = true, silent = true })

vim.keymap.set('n', '<F11>', dap.step_into,
  { desc = 'DAP: step into', noremap = true, silent = true })

vim.keymap.set('n', '<F12>', dap.step_out,
  { desc = 'DAP: step out', noremap = true, silent = true })

-- ═════ Breakpoints ═════
vim.keymap.set('n', '<Leader>B',  dap.toggle_breakpoint,
  { desc = 'DAP: toggle breakpoint', noremap = true, silent = true })

vim.keymap.set('n', '<Leader>lp', function()
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
  end,
  { desc = 'DAP: set log-point', noremap = true, silent = true })

-- ═════ REPL & rerun ═════
vim.keymap.set('n', '<Leader>dr', dap.repl.open,
  { desc = 'DAP: open REPL', noremap = true, silent = true })

vim.keymap.set('n', '<Leader>dl', dap.run_last,
  { desc = 'DAP: run last', noremap = true, silent = true })

-- ═════ UI widgets ═════
vim.keymap.set({'n','v'}, '<Leader>dh',
  function() require('dap.ui.widgets').hover() end,
  { desc = 'DAP: hover value', noremap = true, silent = true })

vim.keymap.set({'n','v'}, '<Leader>dp',
  function() require('dap.ui.widgets').preview() end,
  { desc = 'DAP: preview expression', noremap = true, silent = true })

vim.keymap.set('n', '<Leader>ds', function()
    local w = require('dap.ui.widgets')
    w.centered_float(w.frames)
  end,
  { desc = 'DAP: stack frames', noremap = true, silent = true })

vim.keymap.set('n', '<Leader>dv', function()
    var_sidebar.toggle()          -- opens if closed, closes if open
  end,
  { desc = 'DAP: variables sidebar', noremap = true, silent = true })

local dap = require('dap')
local uv  = vim.loop                -- libuv bindings inside Neovim
local widgets     = require('dap.ui.widgets')
local var_sidebar = widgets.sidebar(
  widgets.scopes,
  {},               -- opts (width/height only)
  'vertical botright split'     -- ← open-command: right-most vsplit
)

-- Adapter definition: uses the vscode-php-debug extension
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/diesi/vscode-php-debug/out/phpDebug.js' },
}

-- Configuration: single launch on port 9003, no UI selection
dap.configurations.php = {
  {
    type = 'php',            -- Adapter type
    request = 'launch',      -- Launch a new process
    name = 'Launch PHP Debug',
    hostname = '172.17.0.1', -- Xdebug host (Docker bridge)
    port = 9003,             -- Fixed Xdebug port
    pathMappings = {
      ['/var/www/html'] = vim.fn.getcwd(),
    },
  },
}

-- Keybinding: F5 to start debug using the above configuration
vim.keymap.set('n', '<F5>', dap.continue, {
  desc = 'DAP: Launch PHP Debug on port 9003',
  noremap = true,
  silent = true,
})

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

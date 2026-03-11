local M = {}

function M.with_quickfix(opts)
  opts = opts or {}
  opts.keymap = opts.keymap or {}
  opts.keymap.fzf = opts.keymap.fzf or {}
  opts.keymap.fzf["ctrl-q"] = "select-all+accept"

  return opts
end

return M

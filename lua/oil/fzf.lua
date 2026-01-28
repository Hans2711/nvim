-- Fuzzy filtering functionality for oil.nvim using fzf-lua
local M = {}

-- Function to fuzzy filter files in current oil directory
M.fuzzy_filter = function()
  local oil = require("oil")
  local fzf = require("fzf-lua")
  
  -- Get the current directory from oil
  local current_dir = oil.get_current_dir()
  
  if not current_dir then
    vim.notify("Not in an oil buffer", vim.log.levels.WARN)
    return
  end
  
  -- Normalize the path
  current_dir = vim.fn.fnamemodify(current_dir, ":p")
  
  -- Open fzf-lua to find files in the current directory
  fzf.files({
    cwd = current_dir,
    prompt = "Files> ",
    winopts = {
      title = " " .. vim.fn.fnamemodify(current_dir, ":~") .. " ",
      title_pos = "center",
    },
    -- Let fzf-lua handle opening the file with default action
    -- This uses fzf-lua's built-in file opening which works correctly
  })
end

return M

local M = {}

local group = vim.api.nvim_create_augroup("diesi-blade-nav-gf", { clear = true })

local function laravel_root(bufnr)
  local start = vim.api.nvim_buf_get_name(bufnr)
  if start == "" then
    start = vim.loop.cwd()
  end

  local artisan = vim.fs.find("artisan", { upward = true, path = start })[1]
  if artisan then
    return vim.fs.dirname(artisan)
  end

  local git_dir = vim.fs.find(".git", { upward = true, path = start })[1]
  if git_dir then
    return vim.fs.dirname(git_dir)
  end

  return vim.loop.cwd()
end

local function quoted_string_under_cursor(line, col)
  local best

  for _, quote in ipairs({ "'", '"' }) do
    local start_pos = 1
    while true do
      local from, to = line:find(quote .. "([^" .. quote .. "]*)" .. quote, start_pos)
      if not from then
        break
      end

      if col >= from and col <= to then
        best = {
          text = line:sub(from + 1, to - 1),
          from = from,
          to = to,
          quote = quote,
        }
      end

      start_pos = to + 1
    end
  end

  return best
end

local function cursor_context()
  local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
  local col = col0 + 1
  local quoted = quoted_string_under_cursor(line, col)

  if not quoted then
    return nil
  end

  return {
    arg = quoted.text,
    before = line:sub(1, quoted.from - 1),
    line = line,
  }
end

local function edit(path)
  vim.cmd.edit(vim.fn.fnameescape(path))
  return true
end

local function open_view(name)
  local root = laravel_root(0)
  local view = name:gsub("%.", "/")
  return edit(root .. "/resources/views/" .. view .. ".blade.php")
end

local function open_config(name)
  local root = laravel_root(0)
  local file = name:match("^[^%.]+")
  if not file or file == "" then
    return false
  end

  return edit(root .. "/config/" .. file .. ".php")
end

local function open_route(name)
  local ok, route_module = pcall(require, "blade-nav.gf_routes")
  if ok and type(route_module) == "table" and type(route_module.gf) == "function" then
    return route_module.gf(name)
  end

  return false
end

local function handle_module_navigation()
  local ctx = cursor_context()
  if not ctx then
    return false
  end

  local before = ctx.before
  local arg = ctx.arg

  if before:match("@extends%s*%($")
    or before:match("@include%w*%s*%($")
    or before:match("@component%s*%($")
    or before:match("view%s*%($")
    or before:match("View::make%s*%($")
    or before:match("markdown%s*%($")
    or before:match("Route::view%s*%([^,]+,%s*$")
  then
    return open_view(arg)
  end

  if before:match("config%s*%($") or before:match("Config::[gs]et%s*%($") then
    return open_config(arg)
  end

  if before:match("route%s*%($") or before:match("to_route%s*%($") then
    return open_route(arg) or false
  end

  return false
end

function M.gf()
  if handle_module_navigation() then
    return
  end

  local ok, blade_nav_gf = pcall(require, "blade-nav.gf")
  if ok and type(blade_nav_gf) == "table" and type(blade_nav_gf.gf) == "function" then
    local ok_call = pcall(blade_nav_gf.gf)
    if ok_call then
      return
    end
  end

  vim.cmd.normal({ "gf", bang = true })
end

function M.attach(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local ft = vim.bo[bufnr].filetype
  if ft ~= "blade" and ft ~= "php" then
    return
  end

  vim.keymap.set("n", "gf", M.gf, {
    buffer = bufnr,
    noremap = true,
    silent = true,
    desc = "Laravel-aware gf",
  })
end

function M.setup()
  vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
    group = group,
    callback = function(args)
      M.attach(args.buf)
    end,
  })

  M.attach(0)
end

return M

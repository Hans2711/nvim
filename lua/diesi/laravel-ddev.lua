-- DDEV adapter for laravel-helper.nvim
-- This module overrides laravel-helper to use DDEV instead of Sail

local M = {}

-- Store the original function
local original_with_sail_or_php = nil

function M.setup()
  -- Wait for laravel-helper to be loaded
  local ok, core = pcall(require, "laravel-helper.core")
  if not ok then
    vim.notify("laravel-helper.core not found", vim.log.levels.WARN)
    return
  end

  -- Store original function if not already stored
  if not original_with_sail_or_php then
    original_with_sail_or_php = core.with_sail_or_php
  end

  -- Override with DDEV version
  core.with_sail_or_php = function(command)
    local laravel_root = core.find_laravel_root()
    if not laravel_root then
      vim.notify("Not a Laravel project", vim.log.levels.WARN)
      return nil
    end

    -- Check if DDEV is available and configured
    local has_ddev = vim.fn.executable("ddev") == 1
    local ddev_config_exists = vim.fn.filereadable(laravel_root .. "/.ddev/config.yaml") == 1

    local cmd
    local use_ddev = false

    if has_ddev and ddev_config_exists then
      -- Check if DDEV project is running
      local handle = io.popen("cd " .. vim.fn.shellescape(laravel_root) .. " && ddev status 2>&1")
      local ddev_status = handle:read("*a")
      handle:close()

      if not ddev_status:match("not running") and not ddev_status:match("not found") then
        use_ddev = true
        -- Use DDEV to execute the command
        cmd = "ddev exec " .. command
      else
        vim.notify("DDEV project not running. Please start with: ddev start", vim.log.levels.WARN)
        return nil
      end
    end

    -- If DDEV is not available, fall back to standard PHP
    if not use_ddev then
      vim.notify("DDEV not configured for this project, using standard PHP", vim.log.levels.INFO)
      cmd = command
    end

    -- Full command with proper directory
    cmd = "cd " .. vim.fn.shellescape(laravel_root) .. " && " .. cmd

    return {
      command = cmd,
      laravel_root = laravel_root,
      use_sail = false,
      use_ddev = use_ddev,
    }
  end

  vim.notify("Laravel Helper configured to use DDEV", vim.log.levels.INFO)
end

return M

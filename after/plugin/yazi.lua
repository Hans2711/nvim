-- '-' toggles the floating Yazi file manager
vim.keymap.set("n", "-", ":Yazi toggle<CR>", { noremap = true, silent = true })

-- '_' opens Yazi in the current directory
vim.keymap.set("n", "_", ":Yazi<CR>", { noremap = true, silent = true })

-- Store yazi's current directory, updated via hover events
_G.yazi_current_cwd = vim.fn.getcwd()

local function debug_inspect(prefix, value)
    local ok, inspected = pcall(vim.inspect, value)
    if not ok then
        inspected = '<uninspectable>'
    end
    vim.notify(string.format('[Yazi] %s %s', prefix, inspected), vim.log.levels.DEBUG)
end

local function resolve_path_like(value)
    if not value then
        return nil
    end

    if type(value) == "string" then
        if value:match("^file://") then
            local ok, decoded = pcall(vim.uri_to_fname, value)
            if ok then
                return decoded
            end
        end
        return value
    end

    local candidate

    local method_names = { "path", "absolute", "as_string", "get" }
    for _, name in ipairs(method_names) do
        local ok, result = pcall(function()
            local method = value[name]
            if type(method) == "function" then
                return method(value)
            end
        end)
        if ok and type(result) == "string" and result ~= "" then
            candidate = result
            break
        end
    end

    if not candidate and type(value) == "table" then
        local field_names = { "path", "_path", "dir", "directory", "url" }
        for _, field in ipairs(field_names) do
            local field_value = value[field]
            if type(field_value) == "string" and field_value ~= "" then
                candidate = field_value
                break
            end
        end
    end

    if not candidate then
        local ok, stringified = pcall(tostring, value)
        if ok and type(stringified) == "string" and stringified ~= "" then
            local extracted = stringified:match('"([^"\n]+)"')
            if extracted and extracted ~= "" then
                candidate = extracted
            elseif stringified:match("^/") then
                candidate = stringified
            end
        end
    end

    return candidate
end

local function normalize_directory(path_like)
    local resolved = resolve_path_like(path_like)
    if not resolved or resolved == "" then
        return nil
    end

    local expanded = vim.fs.normalize(resolved)
    if vim.fn.isdirectory(expanded) == 1 then
        return expanded
    end

    return vim.fn.fnamemodify(expanded, ':h')
end

local function set_tracked_directory(dir, source)
    if not dir or dir == "" then
        return nil
    end

    if _G.yazi_current_cwd ~= dir then
        _G.yazi_current_cwd = dir
        if source then
            vim.notify(string.format('[Yazi] Tracking directory (%s) %s', source, dir), vim.log.levels.DEBUG)
        else
            vim.notify('[Yazi] Tracking directory '..dir, vim.log.levels.DEBUG)
        end
    elseif source then
        vim.notify(string.format('[Yazi] Tracking directory unchanged (%s) %s', source, dir), vim.log.levels.DEBUG)
    end

    return dir
end

local function update_tracked_directory(path_like, source)
    local dir = normalize_directory(path_like)
    if dir and dir ~= "" then
        return set_tracked_directory(dir, source)
    end
    return nil
end

-- Listen to hover events to track the current directory in yazi
vim.api.nvim_create_autocmd('User', {
    pattern = 'YaziDDSHover',
    callback = function(event)
        if event.data and event.data.url then
            update_tracked_directory(event.data.url, 'hover')
        end
    end,
})

require("yazi").setup({
    open_for_directories = true,
    keymaps = {
        show_help = "<f2>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-x>",
        open_file_in_tab = "<c-t>",
        grep_in_directory = "<c-s>",
        replace_in_directory = "<c-g>",
        cycle_open_buffers = "<tab>",
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
        change_working_directory = "<c-\\>",
    },
    floating_window_scaling_factor = 1,
    hooks = {
        yazi_opened = function(preselected_path, yazi_buffer_id, config)
            -- Initialize with the directory of the preselected file, or current buffer's directory
            local init_dir
            if preselected_path then
                local path_str = tostring(preselected_path)
                if vim.fn.isdirectory(path_str) == 1 then
                    init_dir = path_str
                else
                    init_dir = vim.fn.fnamemodify(path_str, ':h')
                end
            else
                init_dir = vim.fn.expand('%:p:h')
            end
            update_tracked_directory(init_dir, 'opened')
        end,
    },
    integrations = {
        grep_in_directory = function(directory)
            debug_inspect('grep_in_directory argument', directory)

            local dir = _G.yazi_current_cwd
            if not dir or dir == "" then
                dir = update_tracked_directory(directory, 'integration:grep-arg')
            end

            if not dir or dir == "" then
                local loop_cwd = vim.loop.cwd()
                dir = normalize_directory(loop_cwd) or loop_cwd or vim.fn.getcwd()
                set_tracked_directory(dir, 'integration:grep-fallback')
            end

            vim.notify('[Yazi] grep_in_directory using '..dir, vim.log.levels.DEBUG)
            local ok, fzf = pcall(require, 'fzf-lua')
            if not ok then
                vim.notify('fzf-lua is not available: '..tostring(fzf), vim.log.levels.ERROR)
                return
            end

            vim.schedule(function()
                vim.notify('[Yazi] Launching fzf-lua live_grep in '..dir, vim.log.levels.DEBUG)
                fzf.live_grep({ cwd = dir })

                vim.schedule(function()
                    vim.notify('[Yazi] Entering insert mode for fzf prompt', vim.log.levels.DEBUG)
                    vim.cmd('startinsert')
                end)
            end)
        end,
        replace_in_directory = function(directory)
            debug_inspect('replace_in_directory argument', directory)

            local dir = _G.yazi_current_cwd
            if not dir or dir == "" then
                dir = update_tracked_directory(directory, 'integration:replace-arg')
            end

            if not dir or dir == "" then
                local loop_cwd = vim.loop.cwd()
                dir = normalize_directory(loop_cwd) or loop_cwd or vim.fn.getcwd()
                set_tracked_directory(dir, 'integration:replace-fallback')
            end

            vim.schedule(function()
                vim.notify('[Yazi] replace_in_directory using '..dir, vim.log.levels.DEBUG)
                local ok, grug = pcall(require, "grug-far")
                if not ok then
                    vim.notify('grug-far is not available: '..tostring(grug), vim.log.levels.ERROR)
                    return
                end
                grug.open({
                    prefills = {
                        paths = dir,
                    }
                })
            end)
        end,
    },
})


-- require("yazi").yazi(
--     {
--         ---@type YaziConfig
--         opts = {
--             -- Below is the default configuration. It is optional to set these values.
--             -- You can customize the configuration for each yazi call by passing it to
--             -- yazi() explicitly
--
--             -- enable this if you want to open yazi instead of netrw.
--             -- Note that if you enable this, you need to call yazi.setup() to
--             -- initialize the plugin. lazy.nvim does this for you in certain cases.
--             --
--             -- If you are also using neotree, you may prefer not to bring it up when
--             -- opening a directory:
--             -- {
--             --   "nvim-neo-tree/neo-tree.nvim",
--             --   opts = {
--             --     filesystem = {
--             --       hijack_netrw_behavior = "disabled",
--             --     },
--             --   },
--             -- }
--             open_for_directories = true,
--
--             -- open visible splits as yazi tabs for easy navigation. Requires a yazi
--             -- version more recent than 2024-08-11
--             -- https://github.com/mikavilpas/yazi.nvim/pull/359
--             open_multiple_tabs = true,
--
--             highlight_groups = {
--                 -- See https://github.com/mikavilpas/yazi.nvim/pull/180
--                 hovered_buffer = nil,
--                 -- See https://github.com/mikavilpas/yazi.nvim/pull/351
--                 hovered_buffer_in_same_directory = nil,
--             },
--
--             -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
--             floating_window_scaling_factor = 0.9,
--
--             -- the transparency of the yazi floating window (0-100). See :h winblend
--             yazi_floating_window_winblend = 0,
--
--             -- the log level to use. Off by default, but can be used to diagnose
--             -- issues. You can find the location of the log file by running
--             -- `:checkhealth yazi` in Neovim. Also check out the "reproducing issues"
--             -- section below
--             log_level = vim.log.levels.OFF,
--
--             -- what Neovim should do a when a file was opened (selected) in yazi.
--             -- Defaults to simply opening the file.
--             open_file_function = function(chosen_file, config, state) end,
--
--             -- customize the keymaps that are active when yazi is open and focused. The
--             -- defaults are listed below. Note that the keymaps simply hijack input and
--             -- they are never sent to yazi, so only try to map keys that are never
--             -- needed by yazi.
--             --
--             -- Also:
--             -- - use e.g. `open_file_in_tab = false` to disable a keymap
--             -- - you can customize only some of the keymaps (not all of them)
--             -- - you can opt out of all keymaps by setting `keymaps = false`
--             keymaps = {
--                 show_help = '<f1>',
--                 open_file_in_vertical_split = '<C-v>',
--                 open_file_in_horizontal_split = '<C-x>',
--                 open_file_in_tab = '<C-t>',
--                 grep_in_directory = '<C-s>',
--                 replace_in_directory = '<C-g>',
--                 cycle_open_buffers = '<tab>',
--                 copy_relative_path_to_selected_files = '<C-y>',
--                 send_to_quickfix_list = '<C-q>',
--                 change_working_directory = "<C-\\>",
--             },
--
--             -- completely override the keymappings for yazi. This function will be
--             -- called in the context of the yazi terminal buffer.
--             set_keymappings_function = function(yazi_buffer_id, config, context) end,
--
--             -- the type of border to use for the floating window. Can be many values,
--             -- including 'none', 'rounded', 'single', 'double', 'shadow', etc. For
--             -- more information, see :h nvim_open_win
--             yazi_floating_window_border = 'shadow',
--
--             -- some yazi.nvim commands copy text to the clipboard. This is the register
--             -- yazi.nvim should use for copying. Defaults to "*", the system clipboard
--             clipboard_register = "+",
--
--             hooks = {
--                 -- if you want to execute a custom action when yazi has been opened,
--                 -- you can define it here.
--                 yazi_opened = function(preselected_path, yazi_buffer_id, config)
--                     -- you can optionally modify the config for this specific yazi
--                     -- invocation if you want to customize the behaviour
--                 end,
--
--                 -- when yazi was successfully closed
--                 yazi_closed_successfully = function(chosen_file, config, state) end,
--
--                 -- when yazi opened multiple files. The default is to send them to the
--                 -- quickfix list, but if you want to change that, you can define it here
--                 yazi_opened_multiple_files = function(chosen_files, config, state) end,
--             },
--
--             -- highlight buffers in the same directory as the hovered buffer
--             highlight_hovered_buffers_in_same_directory = true,
--
--             integrations = {
--                 --- What should be done when the user wants to grep in a directory
--                 grep_in_directory = function(directory)
--                     -- the default implementation uses telescope if available, otherwise nothing
--                 end,
--                 grep_in_selected_files = function(selected_files)
--                     -- similar to grep_in_directory, but for selected files
--                 end,
--                 --- Similarly, search and replace in the files in the directory
--                 replace_in_directory = function(directory)
--                     -- default: grug-far.nvim
--                 end,
--                 replace_in_selected_files = function(selected_files)
--                     -- default: grug-far.nvim
--                 end,
--                 -- `grealpath` on OSX, (GNU) `realpath` otherwise
--                 resolve_relative_path_application = ""
--             },
--         },
--     }
-- )

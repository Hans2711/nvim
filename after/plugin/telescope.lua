local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
local actions = require('telescope.actions')
local pickers    = require("telescope.pickers")
local finders    = require("telescope.finders")
local conf       = require("telescope.config").values
local action_state = require("telescope.actions.state")


vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', ":GrepInDirectory<CR>")
vim.keymap.set("n", "<leader>fd", ":FileInDirectory<CR>")
vim.keymap.set('n', '<leader>fc', function() 
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>fe', builtin.resume, {})

vim.keymap.set('n', '<leader>fif', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
vim.keymap.set({"v", "n"}, "<leader>fs", live_grep_args_shortcuts.grep_visual_selection)
vim.keymap.set({"v", "n"}, "<leader>fw", live_grep_args_shortcuts.grep_word_under_cursor)

vim.keymap.set("n", "<leader>fr", function()
    require('diesi.recent').open()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fof", ":Telescope agrolens query=functions<CR>")
vim.keymap.set("n", "<leader>faf", ":Telescope agrolens query=functions buffers=all<CR>")


-- Native function to recursively collect directories as relative paths.
local function find_directories_native()
    local cwd = vim.fn.getcwd()
    -- Get all directories recursively (absolute paths)
    local dirs = vim.fn.globpath(cwd, "**/", 0, 1)
    local unique = {}
    for _, d in ipairs(dirs) do
        -- Convert to relative path using vim.fn.fnamemodify
        local rel = vim.fn.fnamemodify(d, ":.")
        unique[rel] = true
    end
    local results = {}
    for d, _ in pairs(unique) do
        table.insert(results, d)
    end
    table.sort(results)
    return results
end

-- Telescope picker to choose a search directory
local function choose_search_directory()
    local dirs = find_directories_native()
    pickers.new({}, {
        prompt_title = "Choose Directory",
        finder = finders.new_table({
            results = dirs,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                local chosen_dir = selection.value
                actions.close(prompt_bufnr)
                vim.g.search_folder = chosen_dir
                print("Search directory set to: " .. chosen_dir .. " :-D")
                builtin.live_grep({
                    cwd = chosen_dir,
                    prompt_title = "Live Grep in " .. chosen_dir,
                })
            end)
            return true
        end,
    }):find()
end


-- Function to launch live grep in the saved search directory
local function LiveGrepSearchDir()
    local dir = vim.g.search_folder or vim.fn.getcwd()
    builtin.live_grep({
        cwd = dir,
        prompt_title = "Live Grep in " .. dir,
    })
end

-- Key mapping to launch the directory fuzzy finder
vim.keymap.set("n", "<leader>ss", choose_search_directory, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sg", LiveGrepSearchDir, { noremap = true, silent = true })

require('telescope').setup {
    defaults = {
        -- path_display = {
        --     "shorten",
        -- },
        -- mappings = {
        --     i = {
        --         ["<esc>"] = actions.close,
        --     },
        -- },
        file_ignore_patterns = {
            "node_modules",
            ".git",
            -- "public/fileadmin/user_upload",
            -- "public/fileadmin/_processed_",
            -- "public/fileadmin/_temp_",
            -- "public/uploads",
            -- "public/_assets/*",
            -- "public/_assets",
        },
        ripgrep_arguments = {
            'rg',
            '--hidden',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--no-ignore',
            '--no-ignore-vcs',
        }
    },
    pickers = {
        find_files = {
            hidden = true,
            find_command = {
                'rg',
                '--files',
                '--hidden',
                '--no-ignore',
                '--no-ignore-vcs',
                '--follow',
                '--glob',
                '!.git',
            }
        }
    },
    extensions = {
        agrolens = {
            debug = false,
            same_type = true,
            include_hidden_buffers = false,
            disable_indentation = false,
            aliases = {}
        }
    }
}
require("telescope").load_extension("dap")
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("refactoring")
require("telescope").load_extension("agrolens")

-- Blade template filetype detection
vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})

-- Set Blade-specific options
vim.api.nvim_create_autocmd("FileType", {
    pattern = "blade",
    callback = function()
        vim.bo.commentstring = "{{-- %s --}}"
        
        -- Enable better autocomplete by treating Blade somewhat like PHP
        -- This helps LSP understand the context better
        vim.opt_local.iskeyword:append('$')
        vim.opt_local.iskeyword:append('@')
    end,
})

-- Load Blade completion enhancements
require('diesi.blade-completion').setup()

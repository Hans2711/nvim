local ok, treesitter = pcall(require, "nvim-treesitter")
if not ok then
    return
end

treesitter.setup()

local group = vim.api.nvim_create_augroup("diesi-treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
        local ok_start = pcall(vim.treesitter.start, args.buf)
        if not ok_start then
            return
        end

        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        local win = vim.fn.bufwinid(args.buf)
        if win ~= -1 then
            vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[win].foldmethod = "expr"
        end
    end,
})

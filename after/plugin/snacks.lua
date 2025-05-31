local ok, snacks = pcall(require, 'snacks')
if ok then
    snacks.setup({
        config = {
            priority = 1000,
            lazy = false,
            opts = {
                bigfile = { enabled = true },
                dashboard = { enabled = true },
                explorer = { enabled = true },
                indent = { enabled = true },
                input = { enabled = true },
                notifier = {
                    enabled = true,
                    timeout = 3000,
                },
                picker = { enabled = true },
                quickfile = { enabled = true },
                scope = { enabled = true },
                scroll = { enabled = true },
                statuscolumn = { enabled = true },
                words = { enabled = true },
            },
        }
    })
end

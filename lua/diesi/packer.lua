return require('packer').startup(function(use)
    -- Packer can manage itsel
    use({ "wbthomason/packer.nvim"})
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-live-grep-args.nvim'} }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd( 'colorscheme rose-pine')
        end
    })

    use({ "nvim-treesitter/nvim-treesitter", run = ':TSUpdate'})

    use({"theprimeagen/harpoon"})
    use({"mbbill/undotree"})
    use({"tpope/vim-fugitive"})
    use({"terrortylor/nvim-comment"})

    use({"mg979/vim-visual-multi"})

    use({'hrsh7th/cmp-nvim-lsp'})
    use({'hrsh7th/cmp-buffer'})
    use({'hrsh7th/cmp-path'})
    use({'hrsh7th/cmp-cmdline'})
    use({'hrsh7th/nvim-cmp'})

    use({"neovim/nvim-lspconfig"})

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use({"ray-x/web-tools.nvim"})

    use({"smartpde/telescope-recent-files"})

    use ({"nvim-tree/nvim-web-devicons"})
    use ({"lewis6991/gitsigns.nvim"})
    -- use ({"romgrk/barbar.nvim"})

    use ({"mfussenegger/nvim-dap"})
    use ({"theHamsta/nvim-dap-virtual-text"})
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

    use({"ThePrimeagen/vim-be-good"})
    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }

    use({"m4xshen/autoclose.nvim"})
    use({"alexghergh/nvim-tmux-navigation"})

    use({
        "princejoogie/dir-telescope.nvim",
        -- telescope.nvim is a required dependency
        requires = {"nvim-telescope/telescope.nvim"},
        config = function()
            require("dir-telescope").setup({
                -- these are the default options set
                hidden = true,
                no_ignore = false,
                show_preview = true,
            })
        end,
    })
    use({"elmar-hinz/vim.typoscript"})

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use ({"windwp/nvim-ts-autotag"});

    use({
        'Wansmer/treesj',
        requires = { 'nvim-treesitter/nvim-treesitter' },
    })
    use({"weilbith/nvim-code-action-menu"})
    use({"f-person/git-blame.nvim"})
    use({"folke/trouble.nvim"})
    use({"m-demare/hlargs.nvim"})
    use({"desdic/agrolens.nvim"})
    use({"kr40/nvim-macros"})

    use({"olrtg/nvim-emmet"})

    use({"ms-jpq/chadtree"})

    use({"nvim-tree/nvim-tree.lua"})

    use({
        "mikavilpas/yazi.nvim",
        requires = {
            { "folke/snacks.nvim" },
        },
        config = function()
            require("yazi").setup()
        end,
    })
    use({"MagicDuck/grug-far.nvim"})

    use({"github/copilot.vim"})
    use({"ggandor/leap.nvim"})

    use {
        'smoka7/hop.nvim',
        tag = '*', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }

    use 'stevearc/dressing.nvim'
    use 'MeanderingProgrammer/render-markdown.nvim'
    use 'MunifTanjim/nui.nvim'

    use {
        'yetone/avante.nvim',
        branch = 'main',
        run = 'make',
        config = function()
            require('avante').setup()
        end
    }
end)

-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/diesi/snap/alacritty/common/.cache/nvim/packer_hererocks/2.1.1761727121/share/lua/5.1/?.lua;/home/diesi/snap/alacritty/common/.cache/nvim/packer_hererocks/2.1.1761727121/share/lua/5.1/?/init.lua;/home/diesi/snap/alacritty/common/.cache/nvim/packer_hererocks/2.1.1761727121/lib/luarocks/rocks-5.1/?.lua;/home/diesi/snap/alacritty/common/.cache/nvim/packer_hererocks/2.1.1761727121/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/diesi/snap/alacritty/common/.cache/nvim/packer_hererocks/2.1.1761727121/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["agrolens.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/agrolens.nvim",
    url = "https://github.com/desdic/agrolens.nvim"
  },
  ["autoclose.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/autoclose.nvim",
    url = "https://github.com/m4xshen/autoclose.nvim"
  },
  ["avante.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18avante.config\frequire\0" },
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/avante.nvim",
    url = "https://github.com/yetone/avante.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["dir-telescope.nvim"] = {
    config = { "\27LJ\2\nc\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\17show_preview\2\vhidden\2\14no_ignore\1\nsetup\18dir-telescope\frequire\0" },
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/dir-telescope.nvim",
    url = "https://github.com/princejoogie/dir-telescope.nvim"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["fzf-lua"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["git-blame.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/git-blame.nvim",
    url = "https://github.com/f-person/git-blame.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["grug-far.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/grug-far.nvim",
    url = "https://github.com/MagicDuck/grug-far.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/theprimeagen/harpoon"
  },
  ["hlargs.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/smoka7/hop.nvim"
  },
  ["laravel-helper.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19laravel-helper\frequire\0" },
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/laravel-helper.nvim",
    url = "https://github.com/greggh/laravel-helper.nvim"
  },
  ["leap.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mega.cmdparse"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/mega.cmdparse",
    url = "https://github.com/ColinKennedy/mega.cmdparse"
  },
  ["mega.logging"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/mega.logging",
    url = "https://github.com/ColinKennedy/mega.logging"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-code-action-menu"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-code-action-menu",
    url = "https://github.com/weilbith/nvim-code-action-menu"
  },
  ["nvim-comment"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-comment",
    url = "https://github.com/terrortylor/nvim-comment"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-emmet"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-emmet",
    url = "https://github.com/olrtg/nvim-emmet"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-macros"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-macros",
    url = "https://github.com/kr40/nvim-macros"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tmux-navigation"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-tmux-navigation",
    url = "https://github.com/alexghergh/nvim-tmux-navigation"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/ThePrimeagen/refactoring.nvim"
  },
  ["render-markdown.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/render-markdown.nvim",
    url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"
  },
  ["rose-pine"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\26colorscheme rose-pine\bcmd\bvim\0" },
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/rose-pine",
    url = "https://github.com/rose-pine/neovim"
  },
  ["snacks.nvim"] = {
    commands = { "Snacks" },
    config = { "\27LJ\2\nÚ\4\0\0\b\0!\0&6\0\0\0006\2\1\0'\3\2\0B\0\3\3\15\0\0\0X\2\31€9\2\3\0015\4\31\0005\5\4\0005\6\6\0005\a\5\0=\a\a\0065\a\b\0=\a\t\0065\a\n\0=\a\v\0065\a\f\0=\a\r\0065\a\14\0=\a\15\0065\a\16\0=\a\17\0065\a\18\0=\a\19\0065\a\20\0=\a\21\0065\a\22\0=\a\23\0065\a\24\0=\a\25\0065\a\26\0=\a\27\0065\a\28\0=\a\29\6=\6\30\5=\5 \4B\2\2\1K\0\1\0\vconfig\1\0\1\vconfig\0\topts\nwords\1\0\1\fenabled\2\17statuscolumn\1\0\1\fenabled\2\vscroll\1\0\1\fenabled\2\nscope\1\0\1\fenabled\2\14quickfile\1\0\1\fenabled\2\vpicker\1\0\1\fenabled\2\rnotifier\1\0\2\ftimeout\3¸\23\fenabled\2\ninput\1\0\1\fenabled\2\vindent\1\0\1\fenabled\2\rexplorer\1\0\1\fenabled\2\14dashboard\1\0\1\fenabled\2\fbigfile\1\0\f\14quickfile\0\rnotifier\0\rexplorer\0\fbigfile\0\vpicker\0\14dashboard\0\nscope\0\17statuscolumn\0\vindent\0\vscroll\0\nwords\0\ninput\0\1\0\1\fenabled\2\1\0\3\tlazy\1\topts\0\rpriority\3è\a\nsetup\vsnacks\frequire\npcall\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/opt/snacks.nvim",
    url = "https://github.com/folke/snacks.nvim"
  },
  ["telescope-live-grep-args.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/telescope-live-grep-args.nvim",
    url = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  treesj = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/treesj",
    url = "https://github.com/Wansmer/treesj"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  undotree = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-be-good"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/vim-be-good",
    url = "https://github.com/ThePrimeagen/vim-be-good"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim.typoscript"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/vim.typoscript",
    url = "https://github.com/elmar-hinz/vim.typoscript"
  },
  ["web-tools.nvim"] = {
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/web-tools.nvim",
    url = "https://github.com/ray-x/web-tools.nvim"
  },
  ["yazi.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tyazi\frequire\0" },
    loaded = true,
    path = "/home/diesi/.local/share/nvim/site/pack/packer/start/yazi.nvim",
    url = "https://github.com/mikavilpas/yazi.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: laravel-helper.nvim
time([[Config for laravel-helper.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19laravel-helper\frequire\0", "config", "laravel-helper.nvim")
time([[Config for laravel-helper.nvim]], false)
-- Config for: avante.nvim
time([[Config for avante.nvim]], true)
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18avante.config\frequire\0", "config", "avante.nvim")
time([[Config for avante.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: dir-telescope.nvim
time([[Config for dir-telescope.nvim]], true)
try_loadstring("\27LJ\2\nc\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\17show_preview\2\vhidden\2\14no_ignore\1\nsetup\18dir-telescope\frequire\0", "config", "dir-telescope.nvim")
time([[Config for dir-telescope.nvim]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: yazi.nvim
time([[Config for yazi.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tyazi\frequire\0", "config", "yazi.nvim")
time([[Config for yazi.nvim]], false)
-- Config for: rose-pine
time([[Config for rose-pine]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\26colorscheme rose-pine\bcmd\bvim\0", "config", "rose-pine")
time([[Config for rose-pine]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'Snacks', function(cmdargs)
          require('packer.load')({'snacks.nvim'}, { cmd = 'Snacks', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'snacks.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Snacks ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)


_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

-- Setup language servers

-- Augment client capabilities (e.g. for nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

local function setup_lsp(name, config)
  config = config or {}
  config.capabilities = capabilities
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- Basic servers with default configurations using the new vim.lsp.config API
setup_lsp('pyright')
-- setup_lsp('tsserver')  -- commented out as using ts_ls instead
setup_lsp('cssmodules_ls')
setup_lsp('docker_compose_language_service')
setup_lsp('html')
setup_lsp('jsonls')
setup_lsp('tailwindcss')

-- PHP LSP (Intelephense)
-- setup_lsp('phpactor')  -- commented out as using intelephense instead
setup_lsp('intelephense')

-- Emmet language server with custom filetypes
setup_lsp('emmet_language_server', {
  filetypes = {
    'html',
    'css',
    'blade',
    'typescriptreact',
    'javascriptreact',
  },
})

setup_lsp('ast_grep')
setup_lsp('gopls')

-- Rust analyzer with custom settings
setup_lsp('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {},
  },
})

-- TypeScript language server with custom command and filetypes
setup_lsp('ts_ls', {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
})


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev) -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

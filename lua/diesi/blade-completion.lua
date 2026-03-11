-- Blade template autocomplete and variable awareness enhancement
-- This module provides Laravel-specific completions and variable awareness in Blade templates

local M = {}

-- Common Laravel variables available in Blade templates
local laravel_blade_globals = {
  -- Request data
  '$request',
  '$errors',
  '$message',
  '$messages',
  
  -- Authentication
  '$user',
  '$auth',
  
  -- Common loop variables
  '$loop',
  '$key',
  '$value',
  '$item',
  '$index',
  
  -- Pagination
  '$paginator',
  
  -- Common model variables (these are examples, real ones depend on your controllers)
  '$model',
  '$models',
  '$data',
}

-- Blade directives for autocomplete
local blade_directives = {
  '@if',
  '@elseif',
  '@else',
  '@endif',
  '@unless',
  '@endunless',
  '@isset',
  '@endisset',
  '@empty',
  '@endempty',
  '@auth',
  '@endauth',
  '@guest',
  '@endguest',
  '@production',
  '@endproduction',
  '@env',
  '@endenv',
  '@hasSection',
  '@sectionMissing',
  '@section',
  '@endsection',
  '@yield',
  '@show',
  '@parent',
  '@extends',
  '@include',
  '@includeIf',
  '@includeWhen',
  '@includeUnless',
  '@includeFirst',
  '@each',
  '@once',
  '@endonce',
  '@push',
  '@endpush',
  '@prepend',
  '@endprepend',
  '@stack',
  '@props',
  '@aware',
  '@for',
  '@endfor',
  '@foreach',
  '@endforeach',
  '@forelse',
  '@empty',
  '@endforelse',
  '@while',
  '@endwhile',
  '@continue',
  '@break',
  '@php',
  '@endphp',
  '@csrf',
  '@method',
  '@error',
  '@enderror',
  '@json',
  '@verbatim',
  '@endverbatim',
  '@can',
  '@endcan',
  '@cannot',
  '@endcannot',
  '@canany',
  '@endcanany',
  '@slot',
  '@endslot',
  '@component',
  '@endcomponent',
  '@componentFirst',
  '@endcomponentFirst',
  '@livewire',
  '@livewireScripts',
  '@livewireStyles',
  '@vite',
  '@session',
  '@endsession',
}

-- Laravel helper functions available in Blade
local laravel_helpers = {
  'route',
  'url',
  'asset',
  'config',
  'env',
  'old',
  'session',
  'trans',
  '__',
  'auth',
  'bcrypt',
  'collect',
  'dd',
  'dump',
  'now',
  'today',
  'optional',
  'request',
  'response',
  'view',
  'redirect',
  'back',
  'abort',
  'abort_if',
  'abort_unless',
  'app',
  'cache',
  'class_basename',
  'class_uses_recursive',
  'collect',
  'cookie',
  'csrf_field',
  'csrf_token',
  'decrypt',
  'encrypt',
  'filled',
  'info',
  'logger',
  'method_field',
  'rescue',
  'resolve',
  'storage_path',
  'tap',
  'throw_if',
  'throw_unless',
  'trait_uses_recursive',
  'transform',
  'validator',
  'value',
  'with',
}

function M.setup()
  -- Load Blade snippets if LuaSnip is available
  local ok_luasnip, luasnip = pcall(require, 'luasnip')
  if ok_luasnip then
    local blade_snippets = require('diesi.blade-snippets')
    luasnip.add_snippets('blade', blade_snippets)
  end
  
  -- Setup autocomplete for Blade files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "blade",
    callback = function()
      -- Set up omnifunc for PHP-like completion in Blade
      vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
      
      -- Ensure Intelephense treats this as a PHP file for completion
      vim.bo.syntax = 'blade'
      
      -- Add Blade-specific keywords for better syntax awareness
      vim.opt_local.iskeyword:append('$')
      vim.opt_local.iskeyword:append('@')
    end,
  })
  
  -- Try to enhance completions with nvim-cmp if available
  local ok_cmp, cmp = pcall(require, 'cmp')
  if ok_cmp then
    -- Add custom source for Blade directives and Laravel helpers
    local source = {}
    
    function source:is_available()
      return vim.bo.filetype == 'blade'
    end
    
    function source:get_keyword_pattern()
      return [[\k\+]]
    end
    
    function source:complete(params, callback)
      local items = {}
      
      -- Get current line and cursor position
      local line = params.context.cursor_line
      local col = params.context.cursor.col
      
      -- Check if we're typing a Blade directive
      if line:sub(1, col):match('@%w*$') then
        for _, directive in ipairs(blade_directives) do
          table.insert(items, {
            label = directive,
            kind = cmp.lsp.CompletionItemKind.Keyword,
            detail = 'Blade Directive',
          })
        end
      end
      
      -- Check if we're typing a helper function
      if line:sub(1, col):match('%w+%(') or line:sub(1, col):match('{%{%s*%w+') then
        for _, helper in ipairs(laravel_helpers) do
          table.insert(items, {
            label = helper,
            kind = cmp.lsp.CompletionItemKind.Function,
            detail = 'Laravel Helper',
          })
        end
      end
      
      -- Check if we're typing a variable
      if line:sub(1, col):match('%$%w*$') then
        for _, var in ipairs(laravel_blade_globals) do
          table.insert(items, {
            label = var,
            kind = cmp.lsp.CompletionItemKind.Variable,
            detail = 'Laravel Variable',
          })
        end
      end
      
      callback(items)
    end
    
    -- Register the source
    cmp.register_source('blade', source)
    
    -- Update cmp configuration for blade filetype
    cmp.setup.filetype('blade', {
      sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip', priority = 950 },
        { name = 'blade', priority = 900 },
        { name = 'buffer', priority = 500 },
        { name = 'path', priority = 300 },
      })
    })
  end
  
  vim.notify("Blade autocomplete enhanced", vim.log.levels.INFO)
end

return M

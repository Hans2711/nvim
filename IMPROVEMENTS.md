# Neovim Configuration - Improvements & Issues

Analysis Date: Wed Jan 28 2026

## Critical Issues

### 1. Package Manager Migration Needed
**Location**: `lua/diesi/packer.lua:1-206`
- **Issue**: You're using **Packer.nvim**, which is officially **unmaintained** and archived
- **Impact**: No more updates, bug fixes, or security patches
- **Recommendation**: Migrate to **lazy.nvim** (modern, faster, better lazy-loading)

### 2. Plugin Conflict/Duplication
**Location**: `lua/diesi/packer.lua:23, 186-189`
- **Issue**: You have both `terrortylor/nvim-comment` (line 23) and `numToStr/Comment.nvim` (lines 186-189) installed
- **Impact**: Duplicate functionality, potential keybinding conflicts
- **Recommendation**: Remove one (keep Comment.nvim, it's more actively maintained)

### 3. Inconsistent Snippet Configuration
**Location**: `after/plugin/cmp.lua:27, 30`
- **Issue**: You have `vsnip` source configured in nvim-cmp but you're using `luasnip` as your snippet engine
- **Impact**: Confusion, potential completion issues
- **Recommendation**: Remove vsnip source, add luasnip source

### 4. Telescope vs FZF Confusion
**Location**: `after/plugin/telescope.lua:1-48`, `lua/diesi/remap.lua:35-38`
- **Issue**: File is named `telescope.lua` but contains **fzf-lua** configuration, plus telescope is loaded in packer
- **Impact**: Confusion about which fuzzy finder is actually being used
- **Recommendation**: Rename file to `fzf.lua` or consolidate fuzzy finder choice

### 5. Keymap Conflict
**Location**: `lua/diesi/remap.lua:20`, `after/plugin/harpoon.lua`
- **Issue**: `<leader>a` is mapped to both `:q` (quit) and harpoon's `add_file`
- **Impact**: One mapping will override the other
- **Recommendation**: Choose different keybinding for one of them

---

## Performance Issues

### 6. Missing Lazy Loading
**Location**: `lua/diesi/packer.lua`
- **Issue**: Most plugins load on startup instead of when needed
- **Impact**: Slower startup time
- **Recommendation**: Add lazy loading with conditions (especially for DAP, telescope, etc.)

### 7. Inefficient Treesitter Config
**Location**: `after/plugin/treesitter.lua:3`
- **Issue**: PHP highlighting is disabled but parser is still installed
- **Impact**: Wasted resources
- **Recommendation**: Either enable PHP highlighting or explain why it's disabled

---

## Code Quality Issues

### 8. Hardcoded Path
**Location**: `after/plugin/dap.lua:14`, `lua/diesi/commands.lua:2`
- **Issue**: Absolute paths to `/home/diesi/` directories
- **Impact**: Not portable, won't work on other machines/users
- **Recommendation**: Use environment variables or `vim.fn.stdpath()`

### 9. Snacks.nvim Double Configuration
**Location**: `lua/diesi/packer.lua:116-147`, `after/plugin/snacks.lua`
- **Issue**: Snacks is configured both in packer as a dependency AND in its own plugin file
- **Impact**: Duplicate setup, unclear which config is active
- **Recommendation**: Configure in one place only

### 10. Missing Error Handling
**Location**: `lua/diesi/recent.lua:23, 34`
- **Issue**: File I/O operations without proper error handling
- **Impact**: Could silently fail or crash
- **Recommendation**: Add proper error messages/notifications

---

## Deprecated/Outdated

### 11. Deprecated Telescope Tag
**Location**: `lua/diesi/packer.lua:5`
- **Issue**: Using old telescope tag `0.1.5` (current is 0.1.8+)
- **Recommendation**: Update to latest stable version

### 12. Clipboard Keymaps
**Location**: `lua/diesi/clipboard.lua:2-8`
- **Issue**: Custom clipboard mappings that might conflict with system clipboard
- **Impact**: Could break copy/paste workflows
- **Recommendation**: Test thoroughly or use standard vim clipboard settings

---

## Missing Features

### 13. No Autopairs Configuration
**Location**: `after/plugin/autoclose.lua`
- **Issue**: autoclose.nvim is set up with default config, no customization
- **Recommendation**: Add filetype-specific rules or disable for certain contexts

### 14. LSP Formatting on Save Missing
**Location**: N/A (missing feature)
- **Issue**: No autoformat on save configured
- **Recommendation**: Add autocmd for formatting on `BufWritePre` (optional, based on preference)

### 15. Git Signs Not Configured
**Location**: `lua/diesi/packer.lua:43`
- **Issue**: gitsigns.nvim plugin installed but no configuration file
- **Recommendation**: Create configuration for git diff signs in gutter

---

## Documentation Issues

### 16. No Plugin Comments
**Location**: Throughout `lua/diesi/packer.lua`
- **Issue**: Many plugins have no explanation of why they're installed
- **Recommendation**: Add comments explaining purpose of less obvious plugins

### 17. Commented-Out Code
**Location**: `lua/diesi/packer.lua:19, 27, 44`, `after/plugin/nvim-tree.lua:1`
- **Issue**: Dead code left in configuration
- **Recommendation**: Remove or document why it's commented

---

## Minor Improvements

### 18. Inconsistent Quote Style
**Location**: Throughout configuration files
- **Issue**: Mix of single and double quotes throughout
- **Recommendation**: Standardize on single quotes (Lua convention)

### 19. Missing .gitignore Entry
**Location**: `.gitignore:3`
- **Issue**: Typo `.netrwhistsd` should be `.netrwhist`
- **Impact**: netrwhist file won't be ignored properly

### 20. Avante Provider Hardcoded
**Location**: `after/plugin/avante.lua:4-5`
- **Issue**: OpenAI provider hardcoded with no easy way to switch
- **Recommendation**: Consider environment variable for provider selection

---

## Summary Statistics

- **Critical Issues**: 5
- **Performance Issues**: 2  
- **Code Quality Issues**: 3
- **Deprecated/Outdated**: 2
- **Missing Features**: 3
- **Documentation Issues**: 2
- **Minor Improvements**: 3

**Total Issues Found**: 20

---

## Priority Recommendations

### High Priority (Do First)
1. Fix keymap conflict (#5) - prevents functionality issues
2. Remove duplicate comment plugin (#2) - reduces conflicts
3. Fix snippet configuration (#3) - improves completion
4. Fix .gitignore typo (#19) - simple fix

### Medium Priority
5. Rename telescope.lua to fzf.lua (#4) - reduces confusion
6. Fix hardcoded paths (#8) - improves portability
7. Resolve Snacks double config (#9) - cleaner setup
8. Update telescope version (#11) - get latest features

### Low Priority (Nice to Have)
9. Consider migrating to lazy.nvim (#1) - large task but beneficial
10. Add lazy loading (#6) - improves performance
11. Add error handling to recent.lua (#10) - better reliability
12. Configure gitsigns (#15) - additional feature
13. Review treesitter PHP config (#7) - optimization

### Optional
14. Standardize quote style (#18)
15. Add plugin documentation (#16)
16. Clean up commented code (#17)
17. Review clipboard keymaps (#12)
18. Configure autopairs (#13)
19. Add format on save (#14)
20. Environment-based Avante config (#20)

# Neovim Configuration

This repository contains my personal **Neovim** configuration powered by `packer.nvim`. The setup provides a modern editing experience with useful plugins, language server support and custom key mappings.

## Features

- **Plugin management** using [packer.nvim](https://github.com/wbthomason/packer.nvim).
- **Color scheme** set to `rose-pine`.
- **Treesitter** for syntax highlighting and folding.
- **Telescope** with extensions for live grep, directory search and DAP integration.
- **Harpoon** for quick file marks and terminal commands.
- **UndoTree** and **Fugitive** for undo history and Git integration.
- **nvim-comment** for commenting lines or blocks.
- **Visual-Multi** for multi cursor editing.
- **nvim-cmp** completion with LSP, buffer, path and cmdline sources.
- **LSP configuration** for Python, CSS, Docker Compose, HTML, JSON, Tailwind, PHP, Emmet, AST Grep, Go, Rust and TypeScript.
- **DAP** debugging setup with UI and virtual text (configured for PHP by default).
- **LuaSnip** snippet engine.
- **Refactoring.nvim** via Telescope.
- **Autoclose** for bracket and quote pairs.
- **nvim-tmux-navigation** to navigate between tmux and Neovim splits.
- **dir-telescope.nvim** for directory pickers.
- **nvim-surround** for surrounding text objects.
- **nvim-ts-autotag** to auto close and rename HTML/JSX tags.
- **treesj** for splitting or joining code blocks.
- **Code action menu**, **git-blame** and **trouble.nvim** for diagnostics and git annotations.
- **hlargs** highlighting function arguments.
- **agrolens.nvim** for navigating functions.
- **nvim-macros** storing macros in `macros.json`.
- **nvim-emmet** wrapper around Emmet with Blade template support.
- **CHADTree** and **nvim-tree** file browsers (optional).
- **Yazi** file manager integration with key mappings to toggle.
- **grug-far.nvim** for project wide search and replace.
- **GitHub Copilot**, **Leap** and **Hop** for AI suggestions and fast motions.
- **dressing.nvim**, **render-markdown.nvim** and **nui.nvim** for improved UI widgets.
- **Avante** for AI powered workflows.
- **lualine** statusline and **nvim-web-devicons** for icons.
- **gitsigns.nvim** showing Git changes in the sign column.
- **web-tools.nvim** and **telescope-recent-files** for web utilities and recent file search.
- **nvim-dap-virtual-text**, **nvim-dap-ui** and **vim-be-good** extras.
- **vim.typoscript** syntax support.

### Key mappings

Below is an overview of the custom shortcuts defined throughout this configuration:

- **Movement**
  - `Alt+j` / `Alt+k` move lines or selected blocks down and up.
  - `Ctrl+q` or `Ctrl+Q` quit Neovim.
  - `Esc` in terminal mode returns to Normal mode.
  - `s` jumps to words and `S` to lines using **Hop**.
- **Clipboard**
  - In Visual mode `Ctrl+c`, `Ctrl+v` and `Ctrl+x` copy, paste and cut using the system clipboard.
  - In Insert mode the same keys operate on the current selection.
- **Folds**
  - `+` toggles the current fold while `*` toggles recursively.
- **Harpoon**
  - `leader+a` adds the current file and `Ctrl+b` toggles the quick menu.
  - `leader+1`&ndash;`leader+9` jump to marked files.
  - `leader+t1`&ndash;`leader+t9` open Harpoon terminals and `leader+tt` shows the command menu.
  - Various `leader` mappings (`cund`, `cda`, `cind`, `dcu`, `dcd`, `cc`, `ddn`) trigger predefined shell commands.
- **Telescope**
  - `leader+ff` find files and `leader+gf` search in the current directory.
  - `leader+fd` search files in a chosen directory and `leader+fc` grep for a string.
  - `leader+fe` resume last picker and `leader+fif` run live grep with args.
  - `leader+fs` search visual selection and `leader+fw` search the word under cursor.
  - `leader+fr` open recent files ordered by last usage, `leader+fof` function search and `leader+faf` search functions in all buffers.
  - `leader+ss` pick a search directory and `leader+sg` grep inside it.
- **Yazi**
  - `-` toggles the file manager and `_` opens it in the current path.
- **Emmet**
  - `leader+e` wraps the current selection with an abbreviation.
  - Works in `*.blade.php` templates.
- **Git and Undo**
  - `leader+gs` opens **Fugitive** and `leader+u` toggles **UndoTree**.
- **Debugging (DAP)**
  - `F5` to continue, `F10`/`F11`/`F12` to step, `Leader+B` to toggle breakpoints.
  - `Leader+lp` set a log point, `Leader+dr` open the REPL and `Leader+dl` run last session.
  - `Leader+dh` inspect, `Leader+dp` preview, `Leader+ds` frames and `Leader+dv` scopes.
- **LSP**
  - `space+e`, `[d` and `]d` navigate diagnostics; `space+q` opens the loclist.
  - When attached, `gD`, `gd`, `K`, `gi`, `Ctrl+k`, `space+wa`, `space+wr`, `space+wl`,
    `space+D`, `space+rn`, `space+ca`, `gr` and `space+f` provide LSP actions.
- **Navigation**
  - `Ctrl+h/j/k/l` and `Ctrl+Space` move between tmux and Neovim splits.
- **Treesj**
  - `<space>m` toggles split/join of code blocks (`<space>j` and `<space>s` are also available).

### Additional settings

- Relative line numbers.
- Tabs converted to four spaces.
- Treesitter based folding with `+` and `*` for toggling folds.
- Clipboard mappings for copy/paste with `Ctrl`+`c/v/x` in different modes.

## Usage

Clone this repository as your Neovim configuration directory (`~/.config/nvim/`) and install plugins with `:PackerSync`.


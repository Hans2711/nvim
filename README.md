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
- **nvim-emmet** wrapper around Emmet.
- **CHADTree** and **nvim-tree** file browsers (optional).
- **Yazi** file manager integration with key mappings to toggle.
- **grug-far.nvim** for project wide search and replace.
- **GitHub Copilot**, **Leap** and **Hop** for AI suggestions and fast motions.
- **dressing.nvim**, **render-markdown.nvim** and **nui.nvim** for improved UI widgets.
- **Avante** for AI powered workflows.

### Key mappings

Custom mappings are defined in `lua/diesi/remap.lua` and provide shortcuts for moving lines with `Alt`+`j/k`, quitting with `Ctrl`+`q`, clearing search highlights with `Ctrl`+`g`, navigating harpoon marks and more.

### Additional settings

- Relative line numbers.
- Tabs converted to four spaces.
- Treesitter based folding with `+` and `*` for toggling folds.
- Clipboard mappings for copy/paste with `Ctrl`+`c/v/x` in different modes.

## Usage

Clone this repository as your Neovim configuration directory (`~/.config/nvim/`) and install plugins with `:PackerSync`.


# Neovim Config
 
A personalized Neovim setup configured in Lua. This configuration is built around `lazy.nvim` for plugin management and aims for a modern and efficient development experience.

## 📖 Documentation

- [**Cheatsheet**](./CHEATSHEET.md): A comprehensive list of all keybindings, motions, and shortcuts.
- [**Project Overview**](./GEMINI.md): Details about the project structure, technologies, and conventions.

## Features
 
- **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, declarative plugin management.
- **Completion**: High-performance autocompletion with [blink.cmp](https://github.com/Saghen/blink.cmp).
- **Fast Fuzzy Finding**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for finding files, buffers, and grep.
- **File Explorer**: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) provided as a floating explorer.
- **Syntax & Highlighting**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for robust parsing.
- **AI Assistance**: [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) (Gemini CLI) and [copilot.lua](https://github.com/zbirenbaum/copilot.lua).
- **LSP**: Configured via `mason.nvim`. Includes the "Modern Stack" for Python: `basedpyright` and `ruff`.
- **UI**: [Catppuccin Mocha](https://github.com/catppuccin/nvim) theme and [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) statusline.
- **Terminal**: Floating terminal support with [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim).
- **Debugging**: Full DAP support via [nvim-dap](https://github.com/mfussenegger/nvim-dap).

## Installation

1. **Backup your existing configuration:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **Clone this repository:**
   ```bash
   git clone https://github.com/grimmy0/nvim-config ~/.config/nvim
   ```

3. **Start Neovim:**
   The plugin manager (`lazy.nvim`) will automatically install itself and all plugins on the first start.

## Keybindings

The `<leader>` key is set to `space`. For a full list of commands, see the [CHEATSHEET.md](./CHEATSHEET.md).

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>e`     | Toggle file explorer (`NvimTree`)    |
| `<leader>ff`    | Find files (`Telescope`)             |
| `<leader>fg`    | Live grep (`Telescope`)              |
| `<leader>cc`    | AI Chat (`CodeCompanion`)            |
| `<leader>t`     | Toggle Terminal (`ToggleTerm`)       |
| `gd`            | Go to definition (LSP)               |
| `<F5>`          | Debug: Run/Continue (DAP)            |

## Plugin Management

This configuration uses `lazy.nvim`.

- `:Lazy` - Open the manager UI.
- `:Lazy sync` - Sync and update plugins.
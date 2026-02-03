# Neovim Configuration

## Project Overview

This repository contains a Neovim configuration written in Lua. It uses `lazy.nvim` for plugin management and is structured to separate concerns like plugins, keymaps, and LSP settings.

The configuration is designed to be modular, with each plugin's settings isolated in its own file under the `lua/plugins/` directory. The main entry point is `init.lua`.

Key features and technologies used:
- **Plugin Manager**: `lazy.nvim`
- **Language**: Lua
- **Core Plugins**:
    - `telescope.nvim`: Fuzzy finding for files, buffers, and more.
    - `nvim-tree.lua`: A file explorer sidebar.
    - `nvim-treesitter`: For advanced syntax highlighting and code parsing.
    - `blink.cmp`: High-performance autocompletion framework.
    - `friendly-snippets`: Snippet collection used by completion.
    - `copilot.lua` & `codecompanion.nvim`: AI coding assistants (GitHub Copilot & Gemini CLI).
    - `mason.nvim`: To manage LSP servers, formatters, and linters.
    - `conform.nvim`: Format-on-save (Ruff for Python).
    - `nvim-lint`: Lint-on-save (Ruff + MyPy for Python).
    - `nvim-autopairs` and `nvim-surround`: Editing helpers.
    - `esqueleto.nvim`: File templates for new files.
- **Language Support**:
    - The configuration has built-in LSP support for Python using `basedpyright` and `ruff`.

## Building and Running

This is a Neovim configuration, so there is no traditional "build" step. The files are loaded by Neovim at startup.

### Plugin Management

The project uses `lazy.nvim` to manage plugins. You can manage plugins with the following commands from within Neovim:

- `:Lazy`: Opens the plugin management UI.
- `:Lazy sync`: Updates and cleans plugins.
- `:Lazy update`: Updates plugins.
- `:Lazy install`: Installs missing plugins.

## Development Conventions

- **Entry Point**: `init.lua` is the main file that loads all other configuration modules.
- **Plugin Configuration**: Plugin specifications are imported from the `lua/plugins/` directory by `lua/lazy_setup.lua`. Each plugin's specific configuration is defined in a corresponding file within `lua/plugins/` (e.g., `lua/plugins/telescope.lua`).
- **Keymaps**: Global keymaps are defined in `lua/keymaps.lua`. Plugin-specific keymaps are often set within the plugin's configuration file. The `<leader>` key is set to the spacebar.
- **LSP Configuration**: The Language Server Protocol (LSP) is configured in `lua/lsp.lua`. It uses `mason.nvim` to automatically install and manage LSP servers.

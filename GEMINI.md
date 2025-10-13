# Neovim Configuration

## Project Overview

This repository contains a Neovim configuration written in Lua. It uses `packer.nvim` for plugin management and is structured to separate concerns like plugins, keymaps, and LSP settings.

The configuration is designed to be modular, with each plugin's settings isolated in its own file under the `lua/plugins/` directory. The main entry point is `init.lua`.

Key features and technologies used:
- **Plugin Manager**: `packer.nvim`
- **Language**: Lua
- **Core Plugins**:
    - `telescope.nvim`: Fuzzy finding for files, buffers, and more.
    - `nvim-tree.lua`: A file explorer sidebar.
    - `nvim-treesitter`: For advanced syntax highlighting and code parsing.
    - `nvim-cmp`: Autocompletion framework.
    - `copilot.vim` & `copilot-cmp`: GitHub Copilot integration.
    - `mason.nvim`: To manage LSP servers, formatters, and linters.
- **Language Support**:
    - The configuration has built-in LSP support for Python using `pyright` and `ruff`.

## Building and Running

This is a Neovim configuration, so there is no traditional "build" step. The files are loaded by Neovim at startup.

### Plugin Management

The project uses `packer.nvim` to manage plugins. You can manage plugins with the following commands from within Neovim:

- `:PackerSync`: Updates and cleans plugins. This is the most common command to use.
- `:PackerInstall`: Installs any missing plugins.
- `:PackerUpdate`: Updates all plugins to the latest version.

## Development Conventions

- **Entry Point**: `init.lua` is the main file that loads all other configuration modules.
- **Plugin Configuration**: All plugins are loaded via `lua/plugins.lua`. Each plugin's specific configuration is defined in a corresponding file within the `lua/plugins/` directory (e.g., `lua/plugins/telescope.lua`).
- **Keymaps**: Global keymaps are defined in `lua/keymaps.lua`. Plugin-specific keymaps are often set within the plugin's configuration file. The `<leader>` key is set to the spacebar.
- **LSP Configuration**: The Language Server Protocol (LSP) is configured in `lua/lsp.lua`. It uses `mason.nvim` to automatically install and manage LSP servers.

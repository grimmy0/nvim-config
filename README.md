# Neovim Config
 
A personalized Neovim setup configured in Lua. This configuration is built around `lazy.nvim` for plugin management and aims for a modern and efficient development experience.
 
 ## Features
 
 *   **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, declarative plugin management.
*   **Fast Fuzzy Finding**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) is integrated for finding files, buffers, and searching through code.
*   **File Explorer**: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) provides a clean and simple file tree.
*   **Syntax & Highlighting**: Leverages [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for more accurate and robust syntax highlighting.
*   **Autocompletion**: A powerful completion setup using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
*   **AI Assistance**: Integrated with [GitHub Copilot](https://github.com/github/copilot.vim).
*   **LSP**: Built-in Language Server Protocol support configured via `mason.nvim` for easy server management. Python support (`pyright`, `ruff`) is included out of the box.
*   **UI**: A clean look with the [Catppuccin](https://github.com/catppuccin/nvim) theme.

## Installation

1.  **Backup your existing configuration:**
    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    ```

2.  **Clone this repository:**
    ```bash
    git clone https://github.com/grimmy0/nvim-config ~/.config/nvim
    ```

3.  **Install Packer:**
    Follow the official Packer installation instructions to install the plugin manager.

4.  **Sync Plugins:**
    Open Neovim and run the `:PackerSync` command to install all the plugins defined in the configuration.

    ```
    :PackerSync
    ```

## Keybindings

The `<leader>` key is set to `space`.

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader> e`    | Toggle file explorer (`NvimTree`)    |
| `<leader> ff`   | Find files (`Telescope`)             |
| `<leader> fg`   | Live grep across files (`Telescope`) |
| `gd`            | Go to definition (LSP)               |
| `gD`            | Go to declaration (LSP)              |
| `K`             | Show hover documentation (LSP)       |
| `<leader> rn`   | Rename symbol (LSP)                  |
| `<leader> ca`   | Show code actions (LSP)              |
| `<leader> f`    | Format code (LSP)                    |

## Plugin Management

This configuration uses `packer.nvim` to manage all plugins.

*   To add a new plugin, add a `use` statement to `lua/plugins.lua`.
*   To install new or remove old plugins, run `:PackerSync` inside Neovim.
*   To update all plugins, run `:PackerUpdate`.

# Neovim Config
 
A personalized Neovim setup configured in Lua. This configuration is built around `lazy.nvim` for plugin management and aims for a modern and efficient development experience.

## 📖 Documentation

- [**Cheatsheet**](./CHEATSHEET.md): A comprehensive list of all keybindings, motions, and shortcuts.
- [**Plugin Inventory**](./PLUGINS.md): All plugins with purpose and rationale.
- [**Project Overview**](./GEMINI.md): Details about the project structure, technologies, and conventions.

## Features
 
- **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, declarative plugin management.
- **Completion**: High-performance autocompletion with [blink.cmp](https://github.com/Saghen/blink.cmp).
- **Snippets**: Ready-to-use snippets via [friendly-snippets](https://github.com/rafamadriz/friendly-snippets).
- **Fast Fuzzy Finding**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for finding files, buffers, and grep.
- **File Explorer**: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) provided as a floating explorer.
- **Syntax & Highlighting**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for robust parsing.
- **AI Assistance**: [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) (Gemini CLI) and [copilot.lua](https://github.com/zbirenbaum/copilot.lua).
- **LSP**: Configured via `mason.nvim`. Includes the "Modern Stack" for Python (`basedpyright` and `ruff`) plus `clangd` for C/C++.
- **Formatting**: Format-on-save with [conform.nvim](https://github.com/stevearc/conform.nvim) (Ruff for Python, clang-format for C/C++).
- **Linting**: Lint-on-save with [nvim-lint](https://github.com/mfussenegger/nvim-lint) (MyPy; Ruff diagnostics come from the Ruff LSP server).
- **Python**: Easy virtual environment switching with [venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim), plus templates via [esqueleto.nvim](https://github.com/cvigilv/esqueleto.nvim).
- **C/C++**: `clangd` LSP, `clang-format`, CMake integration via [cmake-tools.nvim](https://github.com/Civitasv/cmake-tools.nvim), and debugging with `codelldb`/`gdb`.
- **Task Runner**: Manage and run tasks (compiler, linter, etc.) with [overseer.nvim](https://github.com/stevearc/overseer.nvim).
- **Editing Helpers**: Auto-pairs with [nvim-autopairs](https://github.com/windwp/nvim-autopairs), surround editing with [nvim-surround](https://github.com/kylechui/nvim-surround), and comment toggling with [Comment.nvim](https://github.com/numToStr/Comment.nvim).
- **Git**: Hunk signs and inline git actions via [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
- **Discoverability**: On-demand keybinding hints with [which-key.nvim](https://github.com/folke/which-key.nvim).
- **Clipboard**: Default yank/paste uses the system clipboard (`clipboard=unnamedplus`).
- **Yank Feedback**: Yanked text briefly highlights to confirm copy actions.
- **UI**: [Catppuccin Mocha](https://github.com/catppuccin/nvim) theme and [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) statusline.

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

4. **Clipboard provider (Linux/macOS):**
   This config enables `unnamedplus`, so install a system clipboard tool for your platform (for example `wl-copy`/`wl-paste`, `xclip`, or `pbcopy`/`pbpaste`).

5. **tree-sitter CLI (>= 0.26.1):**
   Needed by `:TSUpdate` to build parsers. Distro packages are often older; a current binary in `~/.local/bin` (installed here: 0.26.11) takes precedence.

### C/C++

- Mason installs `clangd`, `clang-format`, and `codelldb` automatically on the first start.
- `gdb` is not available through Mason. Install it from your distro (`sudo dnf install gdb` on Fedora) if you want the gdb launch/attach configurations — they stay hidden while gdb is absent.
- clangd needs a `compile_commands.json`. cmake-tools.nvim generates one (`-DCMAKE_EXPORT_COMPILE_COMMANDS=1`) and soft-links it to the project root. For non-CMake projects, generate it yourself (for example `bear -- make`) or add a `compile_flags.txt`.
- Per-project clangd tuning goes in a `.clangd` file; per-project formatting style in `.clang-format`.
- Missing-include fixes come from `~/.config/clangd/config.yaml` (`Diagnostics.MissingIncludes: Strict`), which lives outside this repo because clangd has no command-line flag for it. Without that setting clangd only adds headers when you accept a completion, so a pasted or fully typed symbol yields no fix.
- clangd has no "create function from usage" action; it only generates a definition from an existing declaration (`Add definition`, `Define outline`). Use Copilot or CodeCompanion for generate-from-usage.

## Keybindings

The `<leader>` key is set to `space`. For a full list of commands, see the [CHEATSHEET.md](./CHEATSHEET.md).

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>e`     | Toggle file explorer (`NvimTree`)    |
| `<leader>ff`    | Find files (`Telescope`)             |
| `<leader>fg`    | Live grep (`Telescope`)              |
| `<leader>cc`    | AI Chat (`CodeCompanion`)            |
| `<leader>t`     | Toggle Terminal (`ToggleTerm`)       |
| `<leader>vs`    | Select VirtualEnv (`VenvSelector`)   |
| `<leader>or`    | Run Task (`Overseer`)                |
| `<leader>mb`    | Build CMake target (`CMakeBuild`)    |
| `gd`            | Go to definition (LSP)               |
| `<leader>a`     | Switch source/header (C/C++)         |
| `<F5>`          | Debug: Run/Continue (DAP)            |

## Plugin Management

This configuration uses `lazy.nvim`.

- `:Lazy` - Open the manager UI.
- `:Lazy sync` - Sync and update plugins.

## Maintenance

### Deprecated-API shims (`lua/compat.lua`)

Neovim is removing two long-deprecated APIs: `vim.tbl_islist` (removal target 0.12) and the table form of `vim.validate` (removal target 0.13). `lua/compat.lua` loads before plugins and shims both, keeping sessions quiet today and working the day the APIs disappear.

As of August 2026 these installed plugins still call the old APIs and need the shim:

- `vim.tbl_islist`: codecompanion.nvim, lazy.nvim, mason.nvim, noice.nvim, nui.nvim, nvim-dap, plenary.nvim
- table-form `vim.validate`: esqueleto.nvim, gitsigns.nvim, nvim-dap-ui, nvim-notify, toggleterm.nvim

Retirement condition — after any `:Lazy sync`, run:

```bash
grep -rl 'tbl_islist' ~/.local/share/nvim/lazy/*/lua
grep -rlE 'vim\.validate\(\{' ~/.local/share/nvim/lazy/*/lua
```

When both come back empty, delete `lua/compat.lua` and the `pcall(require, 'compat')` line in `init.lua`.

### Pinned versions

- **nvim-treesitter** is pinned in `lua/plugins/treesitter.lua` to commit `8755152` — the last `main`-branch revision that supports Neovim 0.11 (the branch requires 0.12+ since Apr 2026). Once Neovim 0.12+ is installed: remove the `commit = ...` line, run `:Lazy sync`, then `:TSUpdate`. That is also the right moment to re-run the compat greps above.

### clangd_extensions.nvim is intentionally absent

Everything that plugin used to add is native now: inlay hints via `vim.lsp.inlay_hint` (0.10), type hierarchy via `vim.lsp.buf.typehierarchy` (0.11), and `:LspClangdSwitchSourceHeader` / `:LspClangdShowSymbolInfo` shipped by nvim-lspconfig. Installing it would only duplicate those, so it is left out.

### Known health-check quirks (safe to ignore)

- `:checkhealth nvim-treesitter` reports `…/site/ is not in runtimepath` — an upstream trailing-slash comparison bug; parsers demonstrably load from that directory.
- `:checkhealth noice` warns about optional `regex`/`bash` cmdline parsers — cosmetic.

### Cleanup checklist

- [ ] Neovim 0.12+ lands: unpin nvim-treesitter (see above)
- [ ] After each plugin sync: re-run the compat greps; retire `lua/compat.lua` when both are empty
- [ ] Optional: upstream a `vim.validate` migration PR to esqueleto.nvim (the smallest of the twelve shim dependents)

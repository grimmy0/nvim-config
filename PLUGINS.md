# Plugin Inventory

This document lists every plugin used by this configuration, what it does, and why it is included.

Loading strategy: roughly half the plugins are lazy-loaded — codecompanion/nvim-tree/toggleterm on command or key, telescope on its keys, gitsigns on buffer read, Comment/which-key on VeryLazy, the whole DAP stack on the python/c/cpp filetypes, cmake-tools on the c/cpp/cmake filetypes or its `:CMake*` commands, nvim-treesitter-cpp-tools on the c/cpp filetypes or its `:TSCpp*` commands, telescope-ui-select on the first `vim.ui.select` call. About 20 of 42 plugins load at startup.

| Plugin | What it does | Why we need it |
| :--- | :--- | :--- |
| `folke/lazy.nvim` | Plugin manager and lazy-loader. | Boots and manages all plugins efficiently. |
| `saghen/blink.cmp` | Completion engine. | Fast completion UI and source integration. |
| `giuxtaposition/blink-cmp-copilot` | Copilot source for `blink.cmp`. | Lets Copilot suggestions appear in the completion list. |
| `rafamadriz/friendly-snippets` | Snippet collection. | Provides ready-made snippets for common languages. |
| `catppuccin/nvim` | Colorscheme. | Provides the Catppuccin Mocha theme used by the UI. |
| `olimorris/codecompanion.nvim` | AI assistant UI. | Chat/actions interface for Gemini CLI. |
| `numToStr/Comment.nvim` | Comment toggling. | Fast line/block commenting with standard mappings. |
| `windwp/nvim-autopairs` | Auto-pairs quotes/brackets. | Inserts matching pairs for faster typing. |
| `kylechui/nvim-surround` | Surround editing. | Change/add/remove surrounding quotes/brackets quickly. |
| `stevearc/conform.nvim` | Formatter runner. | Format-on-save for Python using Ruff and for C/C++ using clang-format (with LSP fallback). |
| `mfussenegger/nvim-lint` | Linter runner. | Lint-on-save for Python using MyPy (Ruff diagnostics come from its LSP server). |
| `zbirenbaum/copilot.lua` | GitHub Copilot client. | Enables Copilot integration in Neovim. |
| `mfussenegger/nvim-dap` | Debug Adapter Protocol core. | Base debugging support for Python and C/C++ (codelldb and gdb). |
| `rcarriga/nvim-dap-ui` | DAP UI panels. | Provides the debugging UI layout. |
| `theHamsta/nvim-dap-virtual-text` | Inline DAP info. | Shows variable values in-line while debugging. |
| `mfussenegger/nvim-dap-python` | Python DAP adapter helper. | Simplifies Python debugging setup. |
| `nvim-telescope/telescope-dap.nvim` | Telescope DAP picker. | Lets Telescope browse DAP items. |
| `nvim-neotest/nvim-nio` | Async primitives. | Required dependency for `nvim-dap-ui`. |
| `cvigilv/esqueleto.nvim` | File templates/skeletons. | Inserts Python starter templates on new files. |
| `lewis6991/gitsigns.nvim` | Git hunk signs. | Shows Git diff info and actions in the sign column. |
| `lukas-reineke/indent-blankline.nvim` | Indent guides. | Visual structure for nested blocks. |
| `mason-org/mason.nvim` | LSP/tool installer. | Manages language servers and tools. |
| `WhoIsSethDaniel/mason-tool-installer.nvim` | Mason helper. | Ensures required tools are installed automatically. |
| `neovim/nvim-lspconfig` | LSP configurations. | Wires Neovim to LSP servers like basedpyright/ruff/clangd, and supplies clangd's offset-encoding negotiation plus the switch-source-header and symbol-info commands. |
| `nvim-lualine/lualine.nvim` | Statusline. | Provides the themed statusline. |
| `nvim-tree/nvim-web-devicons` | File icons. | Icons for tree, lualine, and markdown rendering. |
| `nvim-mini/mini.diff` | Lightweight diff support. | Currently disabled but kept for optional diff visuals. |
| `folke/noice.nvim` | UI for messages/cmdline. | Polished commandline and LSP message UI. |
| `MunifTanjim/nui.nvim` | UI component library. | Dependency for Noice UI. |
| `rcarriga/nvim-notify` | Notification UI. | Enhanced notifications used by Noice. |
| `nvim-tree/nvim-tree.lua` | File explorer. | Tree-based file browser with floating view. |
| `stevearc/overseer.nvim` | Task runner. | Run and manage tasks inside Neovim; also backs cmake-tools' build output and the single-file C/C++ compile-and-run tasks in `lua/overseer/template/user/`. |
| `Civitasv/cmake-tools.nvim` | CMake integration. | Configure/build/run/debug CMake targets, and keeps `compile_commands.json` linked at the project root so clangd works. |
| `MeanderingProgrammer/render-markdown.nvim` | Markdown rendering. | Better markdown rendering (also for CodeCompanion). |
| `nvim-telescope/telescope.nvim` | Fuzzy finder. | Find files, buffers, and grep quickly. |
| `nvim-telescope/telescope-ui-select.nvim` | `vim.ui.select` UI. | Renders selection prompts (like overseer's task picker) in telescope instead of the cmdline, where noice's command palette garbled them. |
| `nvim-lua/plenary.nvim` | Lua utility library. | Shared dependency for Telescope, CodeCompanion, and others. |
| `akinsho/toggleterm.nvim` | Terminal manager. | Floating terminal toggle inside Neovim. |
| `nvim-treesitter/nvim-treesitter` | Syntax parser. | Fast syntax highlighting and parsing. Pinned for Neovim 0.11 (see README, Maintenance). |
| `Badhi/nvim-treesitter-cpp-tools` | C++ code generation. | Implements out-of-class member functions, concrete classes from abstract ones, and Rule of 3/5 members — codegen clangd does not provide. |
| `linux-cultist/venv-selector.nvim` | Python venv selector. | Switch Python environments from Neovim. |
| `folke/which-key.nvim` | Keymap helper. | Displays available keybindings on demand. |

# Plugin Inventory

This document lists every plugin used by this configuration, what it does, and why it is included.

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
| `stevearc/conform.nvim` | Formatter runner. | Format-on-save for Python using Ruff (with LSP fallback). |
| `mfussenegger/nvim-lint` | Linter runner. | Lint-on-save for Python using Ruff and MyPy. |
| `zbirenbaum/copilot.lua` | GitHub Copilot client. | Enables Copilot integration in Neovim. |
| `mfussenegger/nvim-dap` | Debug Adapter Protocol core. | Base debugging support. |
| `rcarriga/nvim-dap-ui` | DAP UI panels. | Provides the debugging UI layout. |
| `theHamsta/nvim-dap-virtual-text` | Inline DAP info. | Shows variable values in-line while debugging. |
| `mfussenegger/nvim-dap-python` | Python DAP adapter helper. | Simplifies Python debugging setup. |
| `nvim-telescope/telescope-dap.nvim` | Telescope DAP picker. | Lets Telescope browse DAP items. |
| `nvim-neotest/nvim-nio` | Async primitives. | Required dependency for `nvim-dap-ui`. |
| `cvigilv/esqueleto.nvim` | File templates/skeletons. | Inserts Python starter templates on new files. |
| `lewis6991/gitsigns.nvim` | Git hunk signs. | Shows Git diff info and actions in the sign column. |
| `lukas-reineke/indent-blankline.nvim` | Indent guides. | Visual structure for nested blocks. |
| `williamboman/mason.nvim` | LSP/tool installer. | Manages language servers and tools. |
| `WhoIsSethDaniel/mason-tool-installer.nvim` | Mason helper. | Ensures required tools are installed automatically. |
| `neovim/nvim-lspconfig` | LSP configurations. | Wires Neovim to LSP servers like basedpyright/ruff. |
| `nvim-lualine/lualine.nvim` | Statusline. | Provides the themed statusline. |
| `nvim-tree/nvim-web-devicons` | File icons. | Icons for tree, lualine, and markdown rendering. |
| `nvim-mini/mini.diff` | Lightweight diff support. | Currently disabled but kept for optional diff visuals. |
| `folke/noice.nvim` | UI for messages/cmdline. | Polished commandline and LSP message UI. |
| `MunifTanjim/nui.nvim` | UI component library. | Dependency for Noice UI. |
| `rcarriga/nvim-notify` | Notification UI. | Enhanced notifications used by Noice. |
| `nvim-tree/nvim-tree.lua` | File explorer. | Tree-based file browser with floating view. |
| `stevearc/overseer.nvim` | Task runner. | Run and manage tasks inside Neovim. |
| `MeanderingProgrammer/render-markdown.nvim` | Markdown rendering. | Better markdown rendering (also for CodeCompanion). |
| `nvim-telescope/telescope.nvim` | Fuzzy finder. | Find files, buffers, and grep quickly. |
| `nvim-lua/plenary.nvim` | Lua utility library. | Shared dependency for Telescope, CodeCompanion, and others. |
| `akinsho/toggleterm.nvim` | Terminal manager. | Floating terminal toggle inside Neovim. |
| `nvim-treesitter/nvim-treesitter` | Syntax parser. | Fast syntax highlighting and parsing. |
| `linux-cultist/venv-selector.nvim` | Python venv selector. | Switch Python environments from Neovim. |
| `folke/which-key.nvim` | Keymap helper. | Displays available keybindings on demand. |

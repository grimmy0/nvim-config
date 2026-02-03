# Neovim Keybinding Cheatsheet

This document provides a comprehensive list of all keybindings configured in this Neovim setup, organized by category.

**Leader Key:** `Space` (`<leader>`)

---

## 🔍 Navigation & Search

| Key | Description | Plugin |
| :--- | :--- | :--- |
| `<leader>ff` | Find files in the current directory | `telescope.nvim` |
| `<leader>fg` | Live grep (search text across files) | `telescope.nvim` |
| `<leader>fb` | List open buffers | `telescope.nvim` |
| `<leader>e` | Toggle File Explorer (Float) | `nvim-tree.lua` |

## 📑 Buffer Management

| Key | Description | Source |
| :--- | :--- | :--- |
| `<leader>bn` | Go to next buffer | `lua/keymaps.lua` |
| `<leader>bp` | Go to previous buffer | `lua/keymaps.lua` |
| `<leader>bb` | Go to alternate (previous used) buffer | `lua/keymaps.lua` |

## 🧠 LSP (Language Server Protocol)

These mappings are active when an LSP server (e.g., `basedpyright`, `ruff`) is attached to the buffer.

| Key | Description | Function |
| :--- | :--- | :--- |
| `gD` | Go to declaration | `vim.lsp.buf.declaration` |
| `gd` | Go to definition | `vim.lsp.buf.definition` |
| `K` | Hover documentation | `vim.lsp.buf.hover` |
| `gI` | Go to implementation | `vim.lsp.buf.implementation` |
| `<C-k>` | Signature help | `vim.lsp.buf.signature_help` |
| `<leader>rn` | Rename symbol | `vim.lsp.buf.rename` |
| `<leader>ca` | Code actions | `vim.lsp.buf.code_action` |
| `gr` | Go to references | `vim.lsp.buf.references` |
| `<leader>f` | Format buffer | `conform.nvim` (fallback to LSP) |

## ✨ Completion (`blink.cmp`)

| Key | Description |
| :--- | :--- |
| `<Tab>` | Select next item / Snippet forward / Fallback |
| `<S-Tab>` | Select previous item / Snippet backward / Fallback |
| `<C-y>` | Accept selected completion |

## 🐞 Debugging (`nvim-dap`)

| Key | Description | Function |
| :--- | :--- | :--- |
| `<F5>` | Run / Continue | `dap.continue` |
| `<F10>` | Step Over | `dap.step_over` |
| `<F11>` | Step Into | `dap.step_into` |
| `<F12>` | Step Out | `dap.step_out` |
| `<leader>b` | Toggle Breakpoint | `dap.toggle_breakpoint` |
| `<leader>B` | Set Conditional Breakpoint | `dap.set_breakpoint` |
| `<leader>lp` | Log Point | `dap.set_breakpoint` |
| `<leader>dr` | Toggle REPL | `dap.repl.toggle` |
| `<leader>do` | Open Debug UI | `dapui.open` |
| `<leader>dc` | Close Debug UI | `dapui.close` |
| `<leader>dt` | Terminate Debug Session | `dap.terminate` |
| `<leader>ds` | Disconnect Session | `dap.disconnect` |
| `<leader>de` | Evaluate Expression (in UI) | `dapui.eval` |

## 🤖 AI Assistance

| Key | Description | Plugin |
| :--- | :--- | :--- |
| `<leader>cc` | Open Chat | `codecompanion.nvim` |
| `<leader>cA` | Open Actions | `codecompanion.nvim` |

## 💻 Terminal (`toggleterm.nvim`)

| Key | Description | Plugin |
| :--- | :--- | :--- |
| `<leader>t` | Toggle Floating Terminal | `toggleterm.nvim` |
| `Esc` | Exit Terminal Mode | `toggleterm.nvim` |
| `jk` | Exit Terminal Mode | `toggleterm.nvim` |

## 🐍 Python Environment (`venv-selector.nvim`)

| Key | Description | Plugin |
| :--- | :--- | :--- |
| `<leader>vs` | Select Virtual Environment | `venv-selector.nvim` |

## 🧩 Templates (`esqueleto.nvim`)

Templates are offered when creating new files (e.g., `*.py`, `cli.py`).

| Command | Description |
| :--- | :--- |
| `:EsqueletoNew` | Create a new template |

## 🏗️ Task Runner (`overseer.nvim`)

| Key | Description | Plugin |
| :--- | :--- | :--- |
| `<leader>or` | Run Task | `overseer.nvim` |
| `<leader>ot` | Toggle Task List | `overseer.nvim` |
| `<leader>oa` | Task Action | `overseer.nvim` |
| `<leader>oi` | Overseer Health | `overseer.nvim` |

## 💬 Comments (`Comment.nvim`)

These are the default mappings provided by the plugin.

| Key | Description | Mode |
| :--- | :--- | :--- |
| `gcc` | Toggle comment on current line | Normal |
| `gbc` | Toggle block comment on current line | Normal |
| `gc` | Toggle comment (followed by motion) | Normal |
| `gb` | Toggle block comment (followed by motion) | Normal |
| `gc` | Toggle comment on selection | Visual |
| `gb` | Toggle block comment on selection | Visual |

## 🔁 Surround (`nvim-surround`)

These are the default mappings provided by the plugin.

| Key | Description | Mode |
| :--- | :--- | :--- |
| `ys{motion}{char}` | Add surrounding | Normal |
| `ds{char}` | Delete surrounding | Normal |
| `cs{old}{new}` | Change surrounding | Normal |
| `S{char}` | Surround selection | Visual |

## 🌳 Git (`gitsigns.nvim`)

These are the default mappings provided by the plugin (since `setup()` is called without arguments).

| Key | Description |
| :--- | :--- |
| `]c` | Next Hunk |
| `[c` | Previous Hunk |
| `<leader>hs` | Stage Hunk |
| `<leader>hr` | Reset Hunk |
| `<leader>hS` | Stage Buffer |
| `<leader>hu` | Undo Stage Hunk |
| `<leader>hR` | Reset Buffer |
| `<leader>hp` | Preview Hunk |
| `<leader>hb` | Blame Line (Full) |
| `<leader>tb` | Toggle Current Line Blame |
| `<leader>hd` | Diff This |
| `<leader>hD` | Diff This (~) |
| `<leader>td` | Toggle Deleted |

## ⌨️ Other

| Key | Description | Plugin |
| :--- | :--- | :--- |
| `Space` | Leader Key | Core |

---

# 📚 Core Vim/Neovim Reference

This section covers standard Vim motions, commands, and operators that are fundamental to using Neovim efficiently.

## 🏃 Cursor Movement (Normal Mode)

### Basic Directions
| Key | Description |
| :--- | :--- |
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |

### Word Movement
| Key | Description |
| :--- | :--- |
| `w` | Jump forward to start of next word |
| `W` | Jump forward to start of next word (treats punctuation as word part) |
| `e` | Jump forward to end of word |
| `E` | Jump forward to end of word (treats punctuation as word part) |
| `b` | Jump backward to start of word |
| `B` | Jump backward to start of word (treats punctuation as word part) |
| `ge` | Jump backward to end of word |

### Line Movement
| Key | Description |
| :--- | :--- |
| `0` | Jump to start of line |
| `^` | Jump to first non-blank character of line |
| `$` | Jump to end of line |
| `g_` | Jump to last non-blank character of line |
| `gg` | Go to first line of file |
| `G` | Go to last line of file |
| `:<line_num>` | Go to specific line number (e.g., `:10`) |

### Character Search (Inline)
| Key | Description |
| :--- | :--- |
| `f{char}` | Jump forward to character `{char}` |
| `F{char}` | Jump backward to character `{char}` |
| `t{char}` | Jump forward to *before* character `{char}` |
| `T{char}` | Jump backward to *after* character `{char}` |
| `;` | Repeat last `f`/`F`/`t`/`T` search |
| `,` | Repeat last `f`/`F`/`t`/`T` search in reverse |

### Screen Movement
| Key | Description |
| :--- | :--- |
| `Ctrl+u` | Move up half a page |
| `Ctrl+d` | Move down half a page |
| `Ctrl+b` | Move up one full page |
| `Ctrl+f` | Move down one full page |
| `zz` | Center cursor line on screen |
| `zt` | Move cursor line to top of screen |
| `zb` | Move cursor line to bottom of screen |
| `H` | Move to top of screen (High) |
| `M` | Move to middle of screen (Middle) |
| `L` | Move to bottom of screen (Low) |

## ✏️ Editing (Normal Mode)

### Inserting Text
| Key | Description |
| :--- | :--- |
| `i` | Insert before cursor |
| `I` | Insert at start of line |
| `a` | Append after cursor |
| `A` | Append at end of line |
| `o` | Open new line below and insert |
| `O` | Open new line above and insert |

### Deleting & Changing
| Key | Description |
| :--- | :--- |
| `x` | Delete character under cursor |
| `X` | Delete character before cursor |
| `dd` | Delete (cut) current line |
| `dw` | Delete (cut) to next word |
| `D` or `d$` | Delete (cut) to end of line |
| `cc` | Change (replace) entire line |
| `cw` | Change (replace) to next word |
| `ciw` | Change inner word (replaces whole word cursor is on) |
| `caw` | Change a word (includes surrounding space) |
| `r{char}` | Replace character under cursor with `{char}` |
| `R` | Enter Replace mode |
| `u` | Undo |
| `Ctrl+r` | Redo |

### Copy & Paste (Yank & Put)
| Key | Description |
| :--- | :--- |
| `yy` | Yank (copy) current line |
| `yw` | Yank (copy) to next word |
| `y$` | Yank (copy) to end of line |
| `p` | Put (paste) after cursor |
| `P` | Put (paste) before cursor |

## 🔍 Search & Replace

| Key | Description |
| :--- | :--- |
| `/{pattern}` | Search forward for `{pattern}` |
| `?{pattern}` | Search backward for `{pattern}` |
| `n` | Go to next search match |
| `N` | Go to previous search match |
| `*` | Search forward for word under cursor |
| `#` | Search backward for word under cursor |
| `:%s/old/new/g` | Replace all 'old' with 'new' in file |

## 🪟 Window Management

| Key | Description |
| :--- | :--- |
| `:split` or `:sp` | Split horizontal |
| `:vsplit` or `:vsp` | Split vertical |
| `Ctrl+w h/j/k/l` | Move cursor to split (left/down/up/right) |
| `Ctrl+w w` | Cycle between splits |
| `Ctrl+w q` | Close current split |
| `Ctrl+w =` | Equalize split sizes |

## 👁️ Visual Mode

| Key | Description |
| :--- | :--- |
| `v` | Enter character-wise visual mode |
| `V` | Enter line-wise visual mode |
| `Ctrl+v` | Enter block-wise visual mode |
| `>` | Indent selection |
| `<` | Un-indent selection |
| `y` | Yank selection |
| `d` | Delete selection |

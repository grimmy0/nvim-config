-- Extract/inline refactorings that clangd does not provide. Treesitter-based,
-- so it works the same across C, C++, Python and Lua.
--
-- The mappings are `expr = true`: each function returns an operator-pending
-- string rather than performing the edit, so the following motion or visual
-- selection decides what gets extracted. That is also why this is not
-- lazy-loaded through `keys` -- lazy.nvim's key wrapper does not round-trip an
-- expr mapping. VeryLazy keeps it off the startup path instead.
--
-- Upstream also suggests <leader>ree and <leader>rvv for the current line.
-- Both are deliberately omitted: they would make <leader>re and <leader>rv
-- complete mappings that are also prefixes, stalling each behind timeoutlen.
-- Use the equivalent `<leader>re_` and `<leader>rv_` instead ("_" is the
-- current-line textobject).
return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = { 'lewis6991/async.nvim' },
  event = 'VeryLazy',
  config = function()
    local refactoring = require('refactoring')

    -- Extracting a variable in C++ otherwise emits `P name = value;` -- "P" is
    -- the plugin's placeholder for a type it could not infer, and it does not
    -- compile. refactoring.nvim is treesitter-based, so it has no semantic
    -- type information the way clangd does; `auto` is correct for any
    -- expression and lets the compiler do the inference.
    refactoring.setup({
      refactor = {
        extract_var = {
          code_generation = {
            variable_declaration = {
              cpp = function(opts)
                return ('auto %s = %s;'):format(opts.name, opts.value)
              end,
            },
          },
        },
      },
    })

    local map = vim.keymap.set

    map({ 'n', 'x' }, '<leader>re', function()
      return refactoring.extract_func()
    end, { expr = true, desc = 'Refactor: Extract Function' })

    map({ 'n', 'x' }, '<leader>rE', function()
      return refactoring.extract_func_to_file()
    end, { expr = true, desc = 'Refactor: Extract Function To File' })

    map({ 'n', 'x' }, '<leader>rv', function()
      return refactoring.extract_var()
    end, { expr = true, desc = 'Refactor: Extract Variable' })

    map({ 'n', 'x' }, '<leader>ri', function()
      return refactoring.inline_var()
    end, { expr = true, desc = 'Refactor: Inline Variable' })

    map({ 'n', 'x' }, '<leader>rI', function()
      return refactoring.inline_func()
    end, { expr = true, desc = 'Refactor: Inline Function' })

    map({ 'n', 'x' }, '<leader>rs', function()
      return refactoring.select_refactor()
    end, { desc = 'Refactor: Select Refactoring' })
  end,
}

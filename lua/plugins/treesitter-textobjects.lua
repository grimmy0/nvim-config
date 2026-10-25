-- Syntax-aware text objects and motions: `daf` deletes the function under the
-- cursor, `vic` selects a class body, `]m` jumps to the next function start.
--
-- `branch = 'main'` is required to match nvim-treesitter's main branch; the
-- old master branch of this plugin is configured through nvim-treesitter's
-- setup(), which no longer exists.
--
-- Not lazy-loaded through `keys`: the mappings live in x/o modes, and
-- lazy.nvim's key stub would have to re-feed an operator-pending sequence.
-- VeryLazy keeps it off the startup path instead.
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy',
  init = function()
    -- ftplugin/python.vim maps ]m/[m/]M/[M buffer-locally, which would shadow
    -- the global treesitter motions below in Python buffers.
    vim.g.no_python_maps = true
  end,
  config = function()
    require('nvim-treesitter-textobjects').setup({
      select = {
        -- `daf` works from anywhere on the line, not only inside the body.
        lookahead = true,
        -- Functions and classes are moved as whole lines, so `daf` + `p`
        -- never leaves a half line behind.
        selection_modes = {
          ['@function.outer'] = 'V',
          ['@class.outer'] = 'V',
        },
        -- Take the trailing blank line with a function or class, like `ap`
        -- does for paragraphs, so moving one does not leave a double gap.
        include_surrounding_whitespace = function(opts)
          return opts.query_string == '@function.outer' or opts.query_string == '@class.outer'
        end,
      },
      move = { set_jumps = true },
    })

    local select = require('nvim-treesitter-textobjects.select')
    local move = require('nvim-treesitter-textobjects.move')

    local objects = {
      { 'af', '@function.outer', 'function' },
      { 'if', '@function.inner', 'function body' },
      { 'ac', '@class.outer', 'class' },
      { 'ic', '@class.inner', 'class body' },
      { 'aa', '@parameter.outer', 'parameter' },
      { 'ia', '@parameter.inner', 'parameter (inner)' },
    }
    for _, o in ipairs(objects) do
      vim.keymap.set({ 'x', 'o' }, o[1], function()
        select.select_textobject(o[2], 'textobjects')
      end, { desc = 'TS: ' .. o[3] })
    end

    -- ]m/[m replace Neovim's built-in Java-style method motions, which do not
    -- understand C++ or Python.
    local motions = {
      { ']m', move.goto_next_start, 'Next function start' },
      { ']M', move.goto_next_end, 'Next function end' },
      { '[m', move.goto_previous_start, 'Prev function start' },
      { '[M', move.goto_previous_end, 'Prev function end' },
    }
    for _, m in ipairs(motions) do
      vim.keymap.set({ 'n', 'x', 'o' }, m[1], function()
        m[2]('@function.outer', 'textobjects')
      end, { desc = 'TS: ' .. m[3] })
    end
  end,
}

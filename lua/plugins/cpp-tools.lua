-- Codegen clangd does not provide. clangd can only generate a definition from
-- a declaration you already wrote; this fills in the mechanical class
-- boilerplate around that -- out-of-class member implementations, a concrete
-- class from an abstract one, and the Rule of 3/5.
--
-- `main` is required: the Lua module is `nt-cpp-tools`, which does not match
-- the repository name, so lazy.nvim cannot infer it.
return {
  'Badhi/nvim-treesitter-cpp-tools',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  main = 'nt-cpp-tools',
  ft = { 'c', 'cpp' },
  cmd = {
    'TSCppDefineClassFunc',
    'TSCppMakeConcreteClass',
    'TSCppRuleOf3',
    'TSCppRuleOf5',
  },
  keys = {
    {
      '<leader>ci',
      '<cmd>TSCppDefineClassFunc<cr>',
      mode = { 'n', 'v' },
      desc = 'C++ Implement Member Functions',
    },
    { '<leader>cn', '<cmd>TSCppMakeConcreteClass<cr>', desc = 'C++ Concrete Class From Abstract' },
    { '<leader>c3', '<cmd>TSCppRuleOf3<cr>', desc = 'C++ Rule of 3' },
    { '<leader>c5', '<cmd>TSCppRuleOf5<cr>', desc = 'C++ Rule of 5' },
  },
  opts = {
    preview = { quit = 'q', accept = '<tab>' },
    header_extension = 'h',
    source_extension = 'cpp',
  },
}

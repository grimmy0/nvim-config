-- CMake integration, comparable to vscode-cmake-tools.
-- The highest-value setting here is cmake_compile_commands_options: clangd only
-- understands a project once compile_commands.json sits at the source root, and
-- forgetting that link is the single most common "clangd does nothing" cause.
return {
  'Civitasv/cmake-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/overseer.nvim',
  },
  ft = { 'c', 'cpp', 'cmake' },
  cmd = {
    'CMakeGenerate',
    'CMakeBuild',
    'CMakeRun',
    'CMakeDebug',
    'CMakeRunTest',
    'CMakeClean',
    'CMakeSelectBuildType',
    'CMakeSelectBuildTarget',
    'CMakeSelectLaunchTarget',
    'CMakeSelectKit',
    'CMakeSelectConfigurePreset',
    'CMakeSelectBuildPreset',
    'CMakeLaunchArgs',
    'CMakeSettings',
    'CMakeQuickStart',
    'CMakeOpenExecutor',
    'CMakeOpenRunner',
  },
  keys = {
    { '<leader>mg', '<cmd>CMakeGenerate<cr>', desc = 'CMake Generate' },
    { '<leader>mb', '<cmd>CMakeBuild<cr>', desc = 'CMake Build' },
    { '<leader>mr', '<cmd>CMakeRun<cr>', desc = 'CMake Run' },
    { '<leader>md', '<cmd>CMakeDebug<cr>', desc = 'CMake Debug' },
    { '<leader>mt', '<cmd>CMakeRunTest<cr>', desc = 'CMake Run Tests (ctest)' },
    { '<leader>mc', '<cmd>CMakeClean<cr>', desc = 'CMake Clean' },
    { '<leader>ms', '<cmd>CMakeSelectBuildType<cr>', desc = 'CMake Select Build Type' },
    { '<leader>mT', '<cmd>CMakeSelectBuildTarget<cr>', desc = 'CMake Select Build Target' },
    { '<leader>mL', '<cmd>CMakeSelectLaunchTarget<cr>', desc = 'CMake Select Launch Target' },
    { '<leader>ma', '<cmd>CMakeLaunchArgs<cr>', desc = 'CMake Launch Args' },
    { '<leader>mk', '<cmd>CMakeSelectKit<cr>', desc = 'CMake Select Kit' },
    { '<leader>mo', '<cmd>CMakeOpenExecutor<cr>', desc = 'CMake Open Executor Output' },
  },
  opts = {
    cmake_command = 'cmake',
    ctest_command = 'ctest',
    cmake_use_preset = true,
    cmake_regenerate_on_save = true,
    cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1' },
    cmake_build_options = {},
    cmake_build_directory = 'build/${variant:buildType}',
    cmake_compile_commands_options = {
      action = 'soft_link',
      target = vim.uv.cwd,
    },
    -- Reuse the task runner this config already has rather than adding a
    -- second output window.
    cmake_executor = { name = 'overseer' },
    cmake_runner = { name = 'terminal' },
    cmake_dap_configuration = {
      name = 'cpp',
      type = 'codelldb',
      request = 'launch',
      stopOnEntry = false,
      runInTerminal = true,
      console = 'integratedTerminal',
    },
    cmake_virtual_text_support = true,
  },
}

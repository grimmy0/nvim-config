local overseer = require("overseer")

return {
  generator = function(opts, cb)
    local tasks = {
      { name = "Poetry Install", cmd = { "poetry", "install" } },
      { name = "Poetry Update", cmd = { "poetry", "update" } },
      { name = "Poetry Check", cmd = { "poetry", "check" } },
      { name = "Poetry Shell", cmd = { "poetry", "shell" } },
    }

    local ret = {}
    for _, task in ipairs(tasks) do
      table.insert(ret, overseer.wrap_template(task, {
        name = task.name,
        builder = function(params)
          return {
            cmd = task.cmd,
            components = { { "on_output_summarize", max_lines = 10 }, "default" },
          }
        end,
      }))
    end

    cb(ret)
  end,
  condition = {
    callback = function(search)
      return vim.fn.filereadable(search.dir .. "/pyproject.toml") == 1 
             or vim.fn.filereadable(search.dir .. "/poetry.lock") == 1
    end,
  },
}

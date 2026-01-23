local condition = {
  callback = function(search)
    local files = vim.fs.find({ "pyproject.toml", "poetry.lock" }, { upward = true, path = search.dir })
    return #files > 0
  end,
}

return {
  {
    name = "Poetry Install",
    builder = function()
      return {
        cmd = { "poetry", "install" },
        components = { { "on_output_summarize", max_lines = 10 }, "default" },
      }
    end,
    condition = condition,
  },
  {
    name = "Poetry Update",
    builder = function()
      return {
        cmd = { "poetry", "update" },
        components = { { "on_output_summarize", max_lines = 10 }, "default" },
      }
    end,
    condition = condition,
  },
  {
    name = "Poetry Check",
    builder = function()
      return {
        cmd = { "poetry", "check" },
        components = { { "on_output_summarize", max_lines = 10 }, "default" },
      }
    end,
    condition = condition,
  },
  {
    name = "Poetry Shell",
    builder = function()
      return {
        cmd = { "poetry", "shell" },
        components = { { "on_output_summarize", max_lines = 10 }, "default" },
      }
    end,
    condition = condition,
  },
}

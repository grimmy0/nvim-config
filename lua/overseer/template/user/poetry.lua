local function find_poetry_root(dir)
  return vim.fs.find({ "pyproject.toml", "poetry.lock" }, { upward = true, path = dir })[1]
end

local function build_tasks(root_dir)
  local components = { { "on_output_summarize", max_lines = 10 }, "default" }
  return {
    {
      name = "Poetry Install",
      builder = function()
        return {
          cmd = { "poetry", "install" },
          cwd = root_dir,
          components = components,
        }
      end,
    },
    {
      name = "Poetry Run",
      params = {
        args = {
          type = "list",
          subtype = { type = "string" },
          delimiter = " ",
          optional = true,
          default = {},
          desc = "Arguments passed to `poetry run`",
        },
      },
      builder = function(params)
        local cmd = { "poetry", "run" }
        if params.args and #params.args > 0 then
          vim.list_extend(cmd, params.args)
        end
        return {
          cmd = cmd,
          cwd = root_dir,
          components = components,
        }
      end,
    },
    {
      name = "Poetry Update",
      builder = function()
        return {
          cmd = { "poetry", "update" },
          cwd = root_dir,
          components = components,
        }
      end,
    },
    {
      name = "Poetry Check",
      builder = function()
        return {
          cmd = { "poetry", "check" },
          cwd = root_dir,
          components = components,
        }
      end,
    },
    {
      name = "Poetry Shell",
      builder = function()
        return {
          cmd = { "poetry", "shell" },
          cwd = root_dir,
          components = components,
        }
      end,
    },
  }
end

---@type overseer.TemplateFileProvider
return {
  generator = function(search)
    local root_file = find_poetry_root(search.dir)
    if not root_file then
      return {}
    end
    local root_dir = vim.fs.dirname(root_file)
    return build_tasks(root_dir)
  end,
  cache_key = function(opts)
    return find_poetry_root(opts.dir)
  end,
}

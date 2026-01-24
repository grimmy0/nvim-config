local function find_poetry_root(dir)
  return vim.fs.find({ "pyproject.toml", "poetry.lock" }, { upward = true, path = dir })[1]
end

local function read_poetry_scripts(root_file)
  local py = vim.fn.exepath("python3")
  if py == "" then
    py = vim.fn.exepath("python")
  end
  if py == "" then
    return {}
  end
  local script = [[
import json
import sys
try:
    import tomllib
except Exception:
    sys.exit(1)

path = sys.argv[1]
with open(path, "rb") as f:
    data = tomllib.load(f)

scripts = {}
tool = data.get("tool", {})
poetry = tool.get("poetry", {})
scripts.update(poetry.get("scripts", {}) or {})
project = data.get("project", {})
scripts.update(project.get("scripts", {}) or {})

print(json.dumps(sorted(scripts.keys())))
]]
  local result = vim.system({ py, "-c", script, root_file }, { text = true }):wait()
  if result.code ~= 0 then
    return {}
  end
  local ok, decoded = pcall(vim.json.decode, result.stdout)
  if not ok or type(decoded) ~= "table" then
    return {}
  end
  return decoded
end

local function build_tasks(root_dir)
  local components = { "default" }
  local tasks = {
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
  return tasks
end

local function add_script_tasks(tasks, scripts, root_dir)
  local components = { "default" }
  for _, script in ipairs(scripts) do
    table.insert(tasks, {
      name = "Poetry Run: " .. script,
      params = {
        args = {
          type = "list",
          subtype = { type = "string" },
          delimiter = " ",
          optional = true,
          default = {},
          desc = "Arguments passed to `poetry run " .. script .. "`",
        },
      },
      builder = function(params)
        local cmd = { "poetry", "run", script }
        if params.args and #params.args > 0 then
          vim.list_extend(cmd, params.args)
        end
        return {
          cmd = cmd,
          cwd = root_dir,
          components = components,
        }
      end,
    })
  end
end

---@type overseer.TemplateFileProvider
return {
  generator = function(search)
    local root_file = find_poetry_root(search.dir)
    if not root_file then
      return {}
    end
    local root_dir = vim.fs.dirname(root_file)
    local tasks = build_tasks(root_dir)
    local scripts = read_poetry_scripts(root_file)
    if #scripts > 0 then
      add_script_tasks(tasks, scripts, root_dir)
    end
    return tasks
  end,
  cache_key = function(opts)
    return find_poetry_root(opts.dir)
  end,
}

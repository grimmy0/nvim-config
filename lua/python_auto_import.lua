local M = {}

local methods = vim.lsp.protocol.Methods
local quickfix_kind = vim.lsp.protocol.CodeActionKind.QuickFix

local function get_python_client(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr, method = methods.textDocument_codeAction })) do
    if client.name == 'basedpyright' or client.name == 'pyright' then
      return client
    end
  end
end

local function get_item_text(item)
  if type(item.textEdit) == 'table' and type(item.textEdit.newText) == 'string' then
    return item.textEdit.newText
  end
  if type(item.insertText) == 'string' then
    return item.insertText
  end
  if type(item.label) == 'string' then
    return item.label
  end
end

local function get_symbol_name(item)
  local text = get_item_text(item)
  if not text or text == '' then
    return
  end
  return text:match('([%a_][%w_]*)')
end

local function get_diagnostic_text(bufnr, diagnostic)
  local end_lnum = diagnostic.end_lnum or diagnostic.lnum
  local end_col = diagnostic.end_col or (diagnostic.col + 1)
  local chunks = vim.api.nvim_buf_get_text(bufnr, diagnostic.lnum, diagnostic.col, end_lnum, end_col, {})
  return table.concat(chunks, '\n')
end

local function find_matching_diagnostic(bufnr, client, lnum, symbol, preferred_col)
  local diagnostics = {}

  for _, is_pull in ipairs({ true, false }) do
    local namespace = vim.lsp.diagnostic.get_namespace(client.id, is_pull)
    vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, {
      namespace = namespace,
      lnum = lnum,
    }))
  end

  local matches = {}

  for _, diagnostic in ipairs(diagnostics) do
    local lsp_diagnostic = diagnostic.user_data and diagnostic.user_data.lsp
    if lsp_diagnostic then
      local diagnostic_text = get_diagnostic_text(bufnr, diagnostic)
      if diagnostic_text == symbol then
        table.insert(matches, diagnostic)
      end
    end
  end

  if #matches == 0 then
    return
  end

  table.sort(matches, function(left, right)
    return math.abs(left.col - preferred_col) < math.abs(right.col - preferred_col)
  end)

  return matches[1]
end

local function make_code_action_params(client, bufnr, diagnostic)
  local start = { diagnostic.lnum + 1, diagnostic.col }
  local end_ = {
    (diagnostic.end_lnum or diagnostic.lnum) + 1,
    diagnostic.end_col or (diagnostic.col + 1),
  }

  local params = vim.lsp.util.make_given_range_params(start, end_, bufnr, client.offset_encoding)
  params.context = {
    diagnostics = { diagnostic.user_data.lsp },
    only = { quickfix_kind },
    triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
  }

  return params
end

local function is_import_action(action)
  if type(action.title) ~= 'string' then
    return false
  end
  return action.title:match('^import%s') or action.title:match('^from%s')
end

local function apply_action(action, client, bufnr)
  local function apply(resolved_action)
    if resolved_action.edit then
      vim.lsp.util.apply_workspace_edit(resolved_action.edit, client.offset_encoding)
    end

    local command = resolved_action.command
    if not command then
      return
    end

    if type(command) ~= 'table' then
      command = resolved_action
    end

    client:exec_cmd(command, {
      bufnr = bufnr,
      client_id = client.id,
    })
  end

  if action.edit or action.command or not client:supports_method(methods.codeAction_resolve) then
    apply(action)
    return
  end

  client:request(methods.codeAction_resolve, action, function(err, resolved_action)
    if err or not resolved_action then
      return
    end
    apply(resolved_action)
  end, bufnr)
end

local function try_auto_import(bufnr, lnum, symbol, preferred_col, attempts)
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= 'python' then
    return
  end

  local client = get_python_client(bufnr)
  if not client then
    return
  end

  local diagnostic = find_matching_diagnostic(bufnr, client, lnum, symbol, preferred_col)
  if not diagnostic then
    if attempts < 4 then
      vim.defer_fn(function()
        try_auto_import(bufnr, lnum, symbol, preferred_col, attempts + 1)
      end, 120)
    end
    return
  end

  client:request(methods.textDocument_codeAction, make_code_action_params(client, bufnr, diagnostic), function(err, actions)
    if err then
      return
    end

    local import_actions = vim.tbl_filter(is_import_action, actions or {})
    if #import_actions == 1 then
      apply_action(import_actions[1], client, bufnr)
      return
    end

    if #import_actions == 0 and attempts < 4 then
      vim.defer_fn(function()
        try_auto_import(bufnr, lnum, symbol, preferred_col, attempts + 1)
      end, 120)
    end
  end, bufnr)
end

function M.setup()
  if M._did_setup then
    return
  end
  M._did_setup = true

  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('PythonAutoImport', { clear = true }),
    pattern = 'BlinkCmpAccept',
    callback = function(args)
      local event = args.data or {}
      local item = event.item or {}
      local context = event.context or {}
      local bufnr = context.bufnr

      if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      if vim.bo[bufnr].filetype ~= 'python' or item.source_id == 'lsp' then
        return
      end

      local symbol = get_symbol_name(item)
      if not symbol then
        return
      end

      local bounds = context.bounds or {}
      local lnum = (bounds.line_number or vim.api.nvim_win_get_cursor(0)[1]) - 1
      local preferred_col = (bounds.start_col or 1) - 1

      vim.defer_fn(function()
        try_auto_import(bufnr, lnum, symbol, preferred_col, 1)
      end, 120)
    end,
  })
end

return M

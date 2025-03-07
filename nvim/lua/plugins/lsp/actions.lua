local ms = require("vim.lsp.protocol").Methods

---@param client vim.lsp.Client
---@param bufnr integer
local function format_sync(client, bufnr)
	vim.lsp.buf.format({
		bufnr = bufnr,
		async = false,
		name = client.name,
		timeout_ms = 3000,
	})
end

local exec_cmd_sync, action_resolve_sync

-- This function is based on how neovim handles code actions
-- https://github.com/neovim/neovim/blob/e96f75a4e60c9082e89c7f61e2ce0647e4ebdf43/runtime/lua/vim/lsp/buf.lua#L704
---@param result lsp.CodeAction | lsp.Command
---@param client vim.lsp.Client
---@param bufnr integer
---@param timeout_ms? integer
---@param attempts integer
local function handle_action_result(result, client, bufnr, timeout_ms, attempts)
	if attempts > 3 then
		vim.notify("Max resolve attempts reached for action " .. result.kind, vim.log.levels.WARN)
		return
	end

	if result.edit then
		local enc = client.offset_encoding or "utf-16"
		vim.lsp.util.apply_workspace_edit(result.edit, enc)
	elseif result.command then
		exec_cmd_sync(client, bufnr, result.command, timeout_ms, attempts + 1)
	else
		action_resolve_sync(client, bufnr, result, timeout_ms, attempts + 1)
	end
end

---@param client vim.lsp.Client
---@param bufnr integer
---@param command lsp.Command
---@param timeout_ms? integer
---@param attempts? integer
function exec_cmd_sync(client, bufnr, command, timeout_ms, attempts)
	client.request_sync(ms.workspace_executeCommand, command, timeout_ms or 3000, bufnr)
end

---@param client vim.lsp.Client
---@param bufnr integer
---@param action lsp.CodeAction
---@param timeout_ms? integer
---@param attempts? integer
function action_resolve_sync(client, bufnr, action, timeout_ms, attempts)
	local res = client.request_sync(ms.codeAction_resolve, action, timeout_ms or 3000, bufnr)
	if res and res.result then
		handle_action_result(res.result, client, bufnr, timeout_ms, attempts or 0)
	end
end

---@param client vim.lsp.Client
---@param bufnr integer
---@param kind string
---@param timeout_ms? integer
---@param attempts? integer
local function code_action_sync(client, bufnr, kind, timeout_ms, attempts)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { kind }, diagnostics = {} }
	local res = client.request_sync(ms.textDocument_codeAction, params, timeout_ms or 3000, bufnr)
	-- codeAction can return either Command or CodeAction[]
	-- https://github.com/neovim/neovim/blob/e96f75a4e60c9082e89c7f61e2ce0647e4ebdf43/runtime/lua/vim/lsp/buf.lua#L766
	for _, r in pairs(res and res.result or {}) do
		handle_action_result(r, client, bufnr, timeout_ms, attempts or 0)
	end
end

---@param client vim.lsp.Client
---@param bufnr integer
local function organize_imports_sync(client, bufnr)
	code_action_sync(client, bufnr, "source.organizeImports")
end

---@param client vim.lsp.Client
---@param bufnr integer
local function fix_all_sync(client, bufnr)
	code_action_sync(client, bufnr, "source.fixAll")
end

return {
	format_sync = format_sync,
	organize_imports_sync = organize_imports_sync,
	fix_all_sync = fix_all_sync,
}

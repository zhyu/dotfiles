local nls = require("null-ls")

local fmt = nls.builtins.formatting
local diag = nls.builtins.diagnostics
local act = nls.builtins.code_actions

local fmt_group = vim.api.nvim_create_augroup("FORMATTING", { clear = true })

local function fmt_on_save(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = fmt_group,
			buffer = bufnr,
			callback = function()
				-- TODO: switch to vim.lsp.buf.format() after upgrading to neovim 0.8
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
				--[[ vim.lsp.buf.format({
                    timeout_ms = 3000,
                    buffer = bufnr,
                    filter = function(client)
                        return client.name == "null-ls"
                    end,
                }) ]]
				-- client is null-ls here, so we are only using it for formatting
				local params = require("vim.lsp.util").make_formatting_params({})
				client.request("textDocument/formatting", params, nil, bufnr)
			end,
		})
	end
end

-- Configuring null-ls
nls.setup({
	sources = {
		----------------
		-- FORMATTING --
		----------------
		-- NOTE:
		-- 1. both needs to be enabled to so prettier can apply eslint fixes
		-- 2. prettierd should come first to prevent occassional race condition
		fmt.prettierd,
		fmt.eslint_d,
		fmt.stylua,
		fmt.isort,
		fmt.black,
		-----------------
		-- DIAGNOSTICS --
		-----------------
		diag.eslint_d,
		------------------
		-- CODE ACTIONS --
		------------------
		act.eslint_d,
	},
	on_attach = function(client, bufnr)
		fmt_on_save(client, bufnr)
	end,
})

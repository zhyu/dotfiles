local create_augrp = vim.api.nvim_create_augroup
local create_aucmd = vim.api.nvim_create_autocmd

local common_grp = create_augrp("common", { clear = true })
-- tab indentation for Golang
create_aucmd("FileType", { pattern = "go", command = "setlocal noet", group = common_grp })
-- Fix No Folds Found for files opened with telescope when using treesitter based folding
-- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-1074076011
create_aucmd("BufRead", {
    callback = function()
        create_aucmd("BufWinEnter", { command = "normal! zx", once = true })
    end,
    group = common_grp
})

-- Set keybindings on LspAttached
create_aucmd("User", {
    pattern = "LspAttached",
    desc = "Set keybindings on LspAttached",
    callback = function ()
        local bufmap = function (mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Displays hover information about the symbol under the cursor
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

        -- Jump to the definition
        bufmap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')

        -- Jump to declaration
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

        -- Lists all the implementations for the symbol under the cursor
        bufmap('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')

        -- Jumps to the definition of the type symbol
        bufmap('n', 'gy', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>')

        -- Lists all the references
        bufmap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')

        -- Displays a function's signature information
        bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

        -- Renames all references to the symbol under the cursor
        bufmap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')

        -- Selects a code action available at the current cursor position
        bufmap('n', '<Leader>ac', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('x', '<Leader>ac', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

        -- Show diagnostics in a floating window
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

        -- List all diagnostics for the current buffer
        bufmap('n', '<Leader>fd', '<cmd>lua require("telescope.builtin").diagnostics({ bufnr = 0 })<cr>')

        -- List all diagnostics for all open buffers
        bufmap('n', '<Leader>fD', '<cmd>lua require("telescope.builtin").diagnostics()<cr>')

        -- Move to the previous diagnostic
        bufmap('n', '<Leader>pd', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

        -- Move to the next diagnostic
        bufmap('n', '<Leader>nd', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
})

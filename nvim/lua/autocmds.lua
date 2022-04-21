local create_augrp = vim.api.nvim_create_augroup
local create_aucmd = vim.api.nvim_create_autocmd

local common_grp = create_augrp("common", { clear = true })
-- quickfix
create_aucmd("QuickFixCmdPost", { command = "nested cwindow", group = common_grp })
-- Highlight the symbol and its references when holding the cursor.
create_aucmd("CursorHold", { command = "silent call CocActionAsync('highlight')", group = common_grp })
-- tab indentation for Golang
create_aucmd("FileType", { pattern = "go", command = "setlocal noet", group = common_grp })
-- Setup formatexpr ts and json
create_aucmd("FileType", { pattern = { "typescript", "json" }, command = "setlocal formatexpr=CocAction('formatSelected')", group = common_grp })
-- Update signature help on jump placeholder.
create_aucmd("User", { pattern = "CocJumpPlaceholder", command = "silent call CocActionAsync('showSignatureHelp')", group = common_grp })

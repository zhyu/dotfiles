local M = {}

M.name      = vim.g.vscode and "vscode" or "nvim"
M.is_vscode = (M.name == "vscode")
M.is_nvim   = not M.is_vscode

return M
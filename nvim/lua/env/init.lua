local M = {}

M.name = vim.g.vscode and "vscode" or "nvim"

-- env/init.lua should return a list of modules to load.
-- init.lua should call this function to load the modules.
M.load = function()
    local modules = require("env." .. M.name)
    for _, module in ipairs(modules) do
        require("env." .. M.name .. "." .. module)
    end
end

return M
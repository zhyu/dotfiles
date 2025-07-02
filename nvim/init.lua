vim.loader.enable()

local env = require("env")

-- setup lazyvim itself (plugins are conditionally loaded in the env)
require("lazyvim")

-- load env-specific config
require("env." .. env.name)
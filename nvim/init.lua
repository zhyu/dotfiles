vim.loader.enable()

-- setup lazyvim itself (plugins are conditionally loaded in the env)
require("lazyvim")

-- load env-specific config
local env = require("env")
env.load()
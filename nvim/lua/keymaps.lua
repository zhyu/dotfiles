local set_map = vim.keymap.set

local nmap = {
    -- repeat a command-line command
    ['<leader>.'] = '@:',

    -- dash
    ['<leader>da'] = {'<Plug>DashSearch', {silent = true}},
}
local vmap = {}
local smap = {}
local xmap = {}
local omap = {}
local imap = {
    ['fd'] = '<esc>',
    ['jk'] = '<esc>',
}
local cmap = {}
local tmap = {}

local default_args = { noremap = true }

for mode, map in pairs({ n = nmap, v = vmap, s = smap, x = xmap, o = omap, i = imap, c = cmap, t = tmap }) do
    for from, to in pairs(map) do
        if type(to) == 'table' then
            set_map(mode, from, to[1], to[2])
        else
            set_map(mode, from, to, default_args)
        end
    end
end

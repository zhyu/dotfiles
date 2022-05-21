local set_map = vim.keymap.set

local nmap = {
    -- repeat a command-line command
    ['<leader>.'] = '@:',

    -- dash
    ['<leader>da'] = {'<Plug>DashSearch', {silent = true}},

    -- gitsigns
    ['<leader>nh'] = {'<cmd>Gitsigns next_hunk<cr>', {silent = true, noremap = true}},
    ['<leader>ph'] = {'<cmd>Gitsigns prev_hunk<cr>', {silent = true, noremap = true}},
    ['<leader>hs'] = {'<cmd>Gitsigns stage_hunk<cr>', {silent = true, noremap = true}},
    ['<leader>hS'] = {'<cmd>Gitsigns stage_buffer<cr>', {silent = true, noremap = true}},
    ['<leader>hr'] = {'<cmd>Gitsigns reset_hunk<cr>', {silent = true, noremap = true}},
    ['<leader>hR'] = {'<cmd>Gitsigns reset_buffer<cr>', {silent = true, noremap = true}},
    ['<leader>hu'] = {'<cmd>Gitsigns undo_stage_hunk<cr>', {silent = true, noremap = true}},
    ['<leader>hp'] = {'<cmd>Gitsigns preview_hunk<cr>', {silent = true, noremap = true}},

    -- telescope
    ['<leader>F'] = function() require('telescope.builtin').builtin() end,
    ['<leader>fp'] = function() require('telescope.builtin').resume() end,
    ['<leader>ff'] = function() require('telescope.builtin').find_files() end,
    ['<leader>fb'] = function() require('telescope.builtin').buffers() end,
    ['<leader>fw'] = function() require('telescope.builtin').grep_string() end,
    ['<leader>fg'] = function() require('telescope.builtin').live_grep() end,
    ['<leader>fs'] = function() require('telescope.builtin').current_buffer_fuzzy_find() end,
    ['<leader>fcm'] = function() require('telescope.builtin').commands() end,
    ['<leader>fcc'] = function() require('telescope').extensions.coc.commands({}) end,
    ['<leader>g'] = function() require('telescope.builtin').git_status() end,
    ['gd'] = function() require('telescope').extensions.coc.definitions({}) end,
    ['gy'] = function() require('telescope').extensions.coc.type_definitions({}) end,
    ['gi'] = function() require('telescope').extensions.coc.implementations({}) end,
    ['gr'] = function() require('telescope').extensions.coc.references({}) end,
}
local vmap = {
    -- gitsigns
    ['<leader>hs'] = {'<cmd>Gitsigns stage_hunk<cr>', {silent = true, noremap = true}},
    ['<leader>hr'] = {'<cmd>Gitsigns reset_hunk<cr>', {silent = true, noremap = true}},
}
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

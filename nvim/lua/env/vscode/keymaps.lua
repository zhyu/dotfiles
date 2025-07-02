local set_map = vim.keymap.set
local vscode = require('vscode')

local function map_to_vscode_cmd(mode, lhs, rhs)
  set_map(mode, lhs, function() vscode.call(rhs) end, { silent = true, noremap = true })
end

-- binocular
map_to_vscode_cmd("n", "<leader>f", "binocular.searchFile")
map_to_vscode_cmd("n", "<leader>fg", "binocular.searchFileContent")

-- Folding
-- Ref: https://github.com/vscode-neovim/vscode-neovim/issues/58#issuecomment-2663266989
-- It's important to map j and k to gj and gk to move the cursor without opening fold.
-- Also, we must use remap = true to create the mapping correctly (noremap = false won't work).
set_map('n', 'j', 'gj', { remap = true, silent = true })
set_map('n', 'k', 'gk', { remap = true, silent = true })

map_to_vscode_cmd('n', 'zM', 'editor.foldAll')
map_to_vscode_cmd('n', 'zR', 'editor.unfoldAll')
map_to_vscode_cmd('n', 'zc', 'editor.fold')
map_to_vscode_cmd('n', 'zC', 'editor.foldRecursively')
map_to_vscode_cmd('n', 'zo', 'editor.unfold')
map_to_vscode_cmd('n', 'zO', 'editor.unfoldRecursively')
map_to_vscode_cmd('n', 'za', 'editor.toggleFold')

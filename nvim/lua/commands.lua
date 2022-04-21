local create_cmd = vim.api.nvim_create_user_command

create_cmd('Format', ':call CocActionAsync("format")', { nargs = 0 })
create_cmd('Fold', ':call CocAction("fold", <f-args>)', { nargs = '?' })
create_cmd('OR', ':call CocActionAsync("runCommand", "editor.action.organizeImport")', { nargs = 0 })

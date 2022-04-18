local tabmode = require 'tabmode'

vim.keymap.set('n', '<Plug>(TabmodeEnter)', tabmode, {silent = true, unique = true})
vim.keymap.set('n', '<leader><Tab>', '<Plug>(TabmodeEnter)', {remap = true, silent = true, unique = true})

vim.api.nvim_create_user_command('TabmodeEnter', tabmode, {force = false})

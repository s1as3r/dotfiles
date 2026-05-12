local gh = require('util').gh

vim.pack.add({ gh('stevearc/aerial.nvim') })

require('aerial').setup()
vim.keymap.set('n', '<leader>l', '<cmd>AerialToggle<cr>', { desc = 'Show Workspace Outline' })

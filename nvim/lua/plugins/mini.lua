local gh = require('util').gh

vim.pack.add({ gh('echasnovski/mini.nvim') })

require('mini.ai').setup({ n_lines = 500 })
require('mini.surround').setup()

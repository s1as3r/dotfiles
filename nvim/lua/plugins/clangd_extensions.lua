local gh = require('util').gh

vim.pack.add({ gh('dchinmay2/clangd_extensions.nvim') })
require('clangd_extensions').setup()

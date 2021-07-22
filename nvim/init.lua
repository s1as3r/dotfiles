-- Plugin Stuff
require('plugins')

require('globals')

-- Settings
require('opts')

-- Mappings
require('keys')

require('statusline')
require('completion')
require('bufferbar')
require('gitsigns')
require('nvimtree')
require('treesitter')

-- LSP
require('lsp')
require('lsp.lua-ls')
require('lsp.bash-ls')
require('lsp.python-ls')
require('lsp.vim-ls')
require('lsp.go-ls')
require('lsp.c-ls')

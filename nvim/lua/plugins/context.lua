local gh = require('util').gh

vim.pack.add({ gh('nvim-treesitter/nvim-treesitter-context') })

require('treesitter-context').setup({
  enable = true,
  max_lines = '20%',
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
})

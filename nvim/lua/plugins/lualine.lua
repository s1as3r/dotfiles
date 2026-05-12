local gh = require('util').gh

vim.pack.add({ gh('nvim-lualine/lualine.nvim') })

require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
})

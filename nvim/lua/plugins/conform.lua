local gh = require('util').gh

vim.pack.add({ gh('stevearc/conform.nvim') })

require('conform').setup({
  notify_on_error = false,
  formatters_by_ft = {
    python = { 'ruff_organize_imports', 'ruff_format' },
    haskell = { 'ormolu' },
    json = { 'jq' },
    html = { 'prettier' },
  },
  default_format_opts = { lsp_format = 'fallback' },
})
vim.keymap.set('n', '<leader>ff', function() require('conform').format({ async = true }) end, { desc = 'Format buffer' })

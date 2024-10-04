return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = false,
    formatters_by_ft = {
      python = { 'isort', 'black' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
  },
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format({ async = true })
      end,
      mode = 'n',
      desc = 'Format buffer',
    },
  },
}

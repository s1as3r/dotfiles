return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    dim = { enabled = true },
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    indent = {
      animate = { enabled = false },
      indent = {
        char = '┊',
      },
      scope = {
        char = '┊',
        hl = 'SnacksIndent1'
      },
    },
    image = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
    picker = { enabled = true },
  },
  keys = {
    { '<C-e>', function() require('snacks').explorer() end, desc = 'Toggle [E]xplorer' }
  }
}

local gh = require('util').gh

vim.pack.add({ gh('folke/snacks.nvim') })

require('snacks').setup({
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    formats = {
      key = function(item)
        return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
      end,
    },
    sections = {
      { section = 'header' },
      { title = "MRU",            padding = 1 },
      { section = "recent_files", limit = 6,                            padding = 1 },
      { title = "MRU ",           file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
      { section = "recent_files", cwd = true,                           limit = 6,  padding = 1 },
      { title = "Sessions",       padding = 1 },
      { section = "projects",     padding = 1 },
      { section = "keys" },
    },
  },
  dim = { enabled = true },
  explorer = { enabled = true, replace_netrw = true },
  indent = { animate = { enabled = false }, indent = { char = '┊' }, scope = { char = '┊', hl = 'SnacksIndent1' } },
  image = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  words = { enabled = true },
  picker = { enabled = true, hidden = true, ignored = true },
})
vim.keymap.set('n', '<C-e>', function() require('snacks').explorer() end, { desc = 'Toggle [E]xplorer' })

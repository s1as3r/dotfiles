local gh = require('util').gh

vim.pack.add({
  { src = gh('saghen/blink.cmp'), version = vim.version.range('1.*') },
  { src = gh('L3MON4D3/LuaSnip'), version = vim.version.range('2.*') },
  gh('rafamadriz/friendly-snippets'),
})

require('luasnip').setup()
vim.schedule(function()
  require('luasnip.loaders.from_vscode').lazy_load()
end)

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev' },
    providers = {
      lazydev = { name = "LazyDev", module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
})

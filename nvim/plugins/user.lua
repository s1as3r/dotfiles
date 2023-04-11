return {
  "khaveesh/vim-fish-syntax",
  "fladson/vim-kitty",
  "lervag/vimtex",
  "simrat39/rust-tools.nvim",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "kdheepak/cmp-latex-symbols",
    },
    opts = function(_, opts)
      local cmp = require "cmp"

      opts.sources = cmp.config.sources {
        { name = "nvim_lsp",      priority = 1000 },
        { name = "luasnip",       priority = 750 },
        { name = "buffer",        priority = 500 },
        { name = "path",          priority = 250 },
        { name = "latex_symbols", priority = 700, options = { strategy = 1 } }
      }
    end
  },
}

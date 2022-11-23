local null_ls = require("null-ls")

local config = {
  header = {
    "███    ██ ██    ██ ██ ███    ███",
    "████   ██ ██    ██ ██ ████  ████",
    "██ ██  ██ ██    ██ ██ ██ ████ ██",
    "██  ██ ██  ██  ██  ██ ██  ██  ██",
    "██   ████   ████   ██ ██      ██",
  },

  mappings = {
    n = {
      ["<leader><enter>"] = { "<cmd>.!bash<cr>", desc = "execute current line as bash command" },
      ["<C-u>"] = { "<C-u>zz" },
      ["<C-d>"] = { "<C-d>zz" },
      ["n"] = { "nzz" },
      ["N"] = { "Nzz" }
    },
  },

  options = {
    opt = {
      guifont = { "CaskaydiaCove Nerd Font Mono", ":h12" }
    }
  },

  lsp = {
    formatting = {
      format_on_save = false,
    },
  },

  plugins = {
    init = {
      { "khaveesh/vim-fish-syntax" },
      { "fladson/vim-kitty" },
      { "lervag/vimtex" },
    },
    ["null-ls"] = {
      sources = {
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.mypy,
        -- null_ls.builtins.diagnostics.pylint,

        -- Bash
        null_ls.builtins.formatting.beautysh,
      }
    },

    ["mason-lspconfig"] = {
      ensure_installed = {
        "rust_analyzer",
        "clangd",
        "pyright",
        "bashls",
        "sumneko_lua",
        "hls",
        "gopls",
        "ltex",
      },
    }
  },
}

return config

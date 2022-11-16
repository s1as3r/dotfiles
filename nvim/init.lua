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
      { "lervag/vimtex" }
    },

    ["mason-lspconfig"] = {
      ensure_installed = {
        "rust_analyzer",
        "clangd",
        "pyright",
        "bashls",
        "sumneko_lua",
        -- "hls",
        "gopls",
        "ltex"
      },
    }
  },
}

return config

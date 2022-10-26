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
    },
  },

  options = {
    opt = {
      guifont = { "CaskaydiaCove Nerd Font Mono", ":h12" }
    }
  },

  plugins = {
    init = {
      { "khaveesh/vim-fish-syntax" },
      { "fladson/vim-kitty" },
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
      },
    }
  },
}

return config

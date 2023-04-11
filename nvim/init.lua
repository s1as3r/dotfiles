return {
  options = {
    opt = {
      guifont = { "CaskaydiaCove Nerd Font Mono", ":h12" }
    }
  },
  lsp = {
    formatting = {
      format_on_save = false,
    },
    setup_handlers = {
      rust_analyzer = function(_, opts)
        opts.settings = {
          ['rust-analyzer'] = {
            check = {
              command = "clippy"
            }
          }
        }
        require("rust-tools").setup { server = opts }
      end
    },
  }
}

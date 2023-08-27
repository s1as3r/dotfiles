return {
    options = {opt = {guifont = {"CaskaydiaCove Nerd Font Mono", ":h12"}}},
    lsp = {
        formatting = {format_on_save = false, timeout_ms = 3200},
        setup_handlers = {
            clangd = function(_, opts)
                require("clangd_extensions").setup({server = opts})
            end,
            rust_analyzer = function(_, opts)
                opts.settings = {
                    ["rust-analyzer"] = {check = {command = "clippy"}}
                }
                require("rust-tools").setup({server = opts})
            end
        },
        config = {clangd = {capabilities = {offsetEncoding = "utf-8"}}}
    }
}

require'lspconfig'.ccls.setup{
    command = { "ccls" },
    on_attach = require'lsp'.common_on_attach
}

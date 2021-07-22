require'lspconfig'.gopls.setup{
    command = { "gopls" },
    on_attach = require'lsp'.common_on_attach
}

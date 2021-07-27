require'lspconfig'.hls.setup{
    cmd = { "haskell-language-server-wrapper", "--lsp"},
    on_attach = require'lsp'.common_on_attach
}

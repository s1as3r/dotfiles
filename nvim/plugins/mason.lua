return {
    "williamboman/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "rust_analyzer", "pyright", "clangd", "bashls", "lua_ls", "hls",
            "gopls", "texlab", "julials"
        }
    }
}

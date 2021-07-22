-- Treesitter
--
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "javascript", "html", "java", "c", "cpp", "bash", "python", "lua", "nix"
    },
    highlight = {enable = true, use_languagetree = true}
}

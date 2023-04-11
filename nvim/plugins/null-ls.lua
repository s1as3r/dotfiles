return {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
        local null_ls = require("null-ls")
        opts.sources = {
            null_ls.builtins.diagnostics.flake8,
            -- null_ls.builtins.diagnostics.ruff,
            null_ls.builtins.diagnostics.mypy,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.diagnostics.fish,
            -- null_ls.builtins.diagnostics.pylint,

            null_ls.builtins.formatting.beautysh,
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort, null_ls.builtins.formatting.jq,
            null_ls.builtins.formatting.prettier
        }
    end
}

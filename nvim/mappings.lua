return {
  n = {
    ["<leader><enter>"] = { "<cmd>.!bash<cr>", desc = "execute current line as bash command" },
    ["<leader>T"] = { "<cmd>Telescope<cr>", desc = "Telescope" },
    ["<C-'>"] = { "<cmd>ToggleTerm<cr>", desc = "toggle terminal" },
    ["<C-u>"] = { "<C-u>zz" },
    ["<C-d>"] = { "<C-d>zz" },
    ["n"] = { "nzz" },
    ["N"] = { "Nzz" },
    L = { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" },
    H = { function() require("astronvim.utils.buffer").nav( -(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Previous buffer" },
  },
}

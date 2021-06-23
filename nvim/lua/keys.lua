local nvim = require 'nvim'

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    nvim.set_keymap(mode, lhs, rhs, options)
end

-- Completion
vim.cmd([[
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]])

-- Open Terminals
map("n", "<C-b>", [[<Cmd>vnew term://zsh<CR>]], nil)
map("n", "<C-x>", [[<Cmd>split term://zsh | resize 10<CR>]], nil)

-- Split Resizing
map("n", "<C-Left>", [[<Cmd>vertical resize +3<CR>]], nil)
map("n", "<C-Right>", [[<Cmd>vertical resize -3<CR>]], nil)
map("n", "<C-Up>", [[<Cmd>resize +3<CR>]], nil)
map("n", "<C-Down>", [[<Cmd>resize -3<CR>]], nil)

-- Vertical Split
map("n", "<C-V>", [[<Cmd>vsplit<CR>]], nil)

-- Glow
map("n", "<Leader>p", [[:Glow<CR>]])

local opt = {noremap = true, silent = true}

-- Telescope
map("n", "<Leader>ff",
    [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
map("n", "<Leader>fg",
    [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
map("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],
    opt)
map("n", "<Leader>fh",
    [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)

-- Nvim Tree
map("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>", opt)

-- Lspsaga
nvim.exec([[
    nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>

nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>


nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
    ]], false)

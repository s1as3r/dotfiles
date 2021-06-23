local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local nvim = require 'nvim'

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

cmd 'syntax enable'
cmd 'filetype plugin indent on'
cmd 'colorscheme javacafe'
opt('b', 'smartindent', true)
opt('b', 'shiftwidth', 4)
opt('b', 'tabstop', 4)
opt('b', 'expandtab', true)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
opt('o', 'termguicolors', true)
opt('o', 'showmode', false)
opt('o', 'showmatch', true)
opt('o', 'mouse', 'a')
opt('o', 'ruler', true)
opt('o', 'laststatus', 2)
opt('o', 'showtabline', 2)
opt('o', 'startofline', false)
opt('o', 'hidden', true)
opt('o', 'backup', false)
opt('o', 'writebackup', false)
opt('o', 'cmdheight', 1)
opt('o', 'updatetime', 300)
opt('o', 'completeopt', "menuone,noinsert,noselect")
opt('o', 'shortmess', "c")
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'wrap', true)
opt('w', 'cursorline', false)
opt('w', 'signcolumn', 'number')

-- Get rid of tildas
cmd [[let &fcs='eob']]

-- Italics
cmd [[let &t_ZH = "\e[3m"]]
cmd [[let &t_ZR = "\e[23m"]]
cmd [[highlight Comment gui=italic]]

-- Format lua on save
cmd [[autocmd FileType lua nnoremap <buffer> <c-p> :call LuaFormat()<cr>]]
cmd [[autocmd BufWrite *.lua call LuaFormat()]]

cmd [[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }]]

cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]

cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

nvim.g.completion_auto_change_source = 1
nvim.g.completion_chain_complete_list = {
    default = {
        {complete_items = {'lsp', 'buffers', 'path'}}, {mode = {'<c-p>'}},
        {mode = {'<c-n>'}}
    }
}

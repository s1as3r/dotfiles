vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require('setup.pack')
require('plugins')

require('setup.lsp')
require('setup.treesitter')
require('setup.telescope')
require('setup.snippets')

local util = require('util')

-- OPTIONS
-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- vim.o.smartindent = true
vim.o.expandtab = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

vim.o.guifont = 'Iosevka Nerd Font Mono:h14'
vim.o.winborder = 'rounded'

-- textwidth
vim.o.textwidth = 90
vim.o.colorcolumn = "-1"

-- whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = '󰌒 ', trail = '.', nbsp = '␣' }

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 5

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },

  virtual_text = true,
  virtual_lines = false,

  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        score = 'cursor',
        focus = false
      })
    end
  }
}

-- KEYMAPS
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 's', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- buffers
vim.keymap.set('n', '<C-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<C-h>', '<cmd>bprevious<cr>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<C-q>', '<cmd>bdelete<cr>', { desc = 'Delete Buffer' })

vim.keymap.set('v', '<C-c>', '"+y', { desc = 'copy to os clipboard' });

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- scroll keymaps
vim.keymap.set('n', '<C-y>', '<C-y>', { desc = 'Scroll Up', remap = false })
vim.keymap.set('n', '<C-b>', '<C-e>', { desc = 'Scroll Down', remap = false })

-- Setting Up Powershell
-- :help shell-powershell
if vim.uv.os_uname().sysname == 'Windows_NT' then
  vim.opt.shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
  vim.opt.shellcmdflag =
  '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';'
  vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end

-- Git Browse using snacks.nvim
vim.api.nvim_create_user_command('Gbrowse', function()
  require('snacks').gitbrowse.open()
end, {})

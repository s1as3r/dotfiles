local gh = require("util").gh

-- lsp
vim.pack.add({
  gh('neovim/nvim-lspconfig'),
  gh('mason-org/mason.nvim'),
  gh('mason-org/mason-lspconfig.nvim'),
  gh('WhoIsSethDaniel/mason-tool-installer.nvim'),
  gh('j-hui/fidget.nvim'),
})
require('fidget').setup({})

-- theme
vim.pack.add({ gh('navarasu/onedark.nvim') })
vim.cmd.colorscheme('onedark')

-- telescope
local telescope_plugins = {
  gh('nvim-lua/plenary.nvim'),
  gh('nvim-telescope/telescope.nvim'),
  gh('nvim-telescope/telescope-live-grep-args.nvim'),
}
if vim.fn.executable('make') == 1 then
  table.insert(telescope_plugins, gh('nvim-telescope/telescope-fzf-native.nvim'))
end
vim.pack.add(telescope_plugins)

-- treesitter
vim.pack.add {
  { src = gh('nvim-treesitter/nvim-treesitter'),             version = 'main' },
  { src = gh('nvim-treesitter/nvim-treesitter-textobjects'), version = 'main' },
}

-- utilities
if vim.g.have_nerd_font then vim.pack.add({ gh('nvim-tree/nvim-web-devicons') }) end

vim.pack.add({
  gh('akinsho/bufferline.nvim'),
  gh('NMAC427/guess-indent.nvim'),
  gh('folke/which-key.nvim'),
  gh('windwp/nvim-autopairs'),
  gh('max397574/better-escape.nvim'),
  gh('numToStr/Comment.nvim'),
  gh('tpope/vim-fugitive'),
  gh('tikhomirov/vim-glsl'),
  gh('NoahTheDuke/vim-just'),
  gh('junegunn/fzf.vim'),
  gh('habamax/vim-godot'),
  gh('folke/lazydev.nvim'),
})

require('bufferline').setup()
require('guess-indent').setup({ auto_cmd = true })
require('which-key').setup()
require('nvim-autopairs').setup()
require('better_escape').setup()
require('Comment').setup()

require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

-- load modular plugin files
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'plugins')
for fname, type in vim.fs.dir(plugins_dir) do
  if type == 'file' and fname:match('%.lua$') and fname ~= 'init.lua' then
    require('plugins.' .. fname:gsub('%.lua$', ''))
  end
end

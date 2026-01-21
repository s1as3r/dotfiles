return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', config = true },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim',    opts = {} },
      'saghen/blink.cmp',
    },
  },

  {
    -- Atom OneDark
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {}
  },

  {
    'NMAC427/guess-indent.nvim',
    opts = {
      auto_cmd = true
    }
  },

  { 'folke/which-key.nvim',         opts = {} },
  { 'windwp/nvim-autopairs',        opts = {} },
  { 'max397574/better-escape.nvim', opts = {} },
  { 'numToStr/Comment.nvim',        opts = {} },
  'tpope/vim-fugitive',
  'tikhomirov/vim-glsl',
  'NoahTheDuke/vim-just',
  'junegunn/fzf.vim',
  'habamax/vim-godot',
}

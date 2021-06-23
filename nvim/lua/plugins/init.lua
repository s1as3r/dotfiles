local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                install_path)
    execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Vim arduino
    use {'stevearc/vim-arduino'}

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- Lua wrappers for nvim
    use {'norcalli/nvim.lua'}

    use {'bakpakin/fennel.vim'}

    use {'bhurlow/vim-parinfer'}

    -- Android smali file highlights
    use {'mzlogin/vim-smali'}

    -- Status Line
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require 'plugins.statusline' end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- Startup Time Plugin
    use 'tweekmonster/startuptime.vim'

    -- Buffer Bar
    use {
        'akinsho/nvim-bufferline.lua',
        config = function() require 'plugins.bufferbar' end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- Colorscheme
    use 'javacafe01/javacafe.vim'

    -- Lua formatter
    use 'andrejlevkovitch/vim-lua-format'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function() require 'plugins.treesitter' end,
        run = ':TSUpdate'
    }

    -- Dash
    use 'glepnir/dashboard-nvim'

    -- Better Colorizer
    use 'norcalli/nvim-colorizer.lua'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- Nvim Tree
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- Nvim Built in LSP configs
    use {"neovim/nvim-lspconfig", config = function() require 'plugins.lsp' end}

    -- Nvim LSP extensions
    use "nvim-lua/lsp_extensions.nvim"

    -- Auto complete stuff
    use "nvim-lua/completion-nvim"
    use "nvim-treesitter/completion-treesitter"
    use "steelsojka/completion-buffers"

    use {"RishabhRD/nvim-lsputils", requires = {'RishabhRD/popfix'}}

    -- Vsnip
    use "hrsh7th/vim-vsnip"

    use 'kosayoda/nvim-lightbulb'

    use 'glepnir/lspsaga.nvim'

    -- Markdown preview
    use {'npxbr/glow.nvim', run = ':GlowInstall'}
end)

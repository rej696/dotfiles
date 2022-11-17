-- Plugin definition and loading
-- local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd

-- Boostrap Packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system {
        'git',
        'clone',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
end

-- disable built in plugins
local disabled_built_ins = {
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Load Packer
cmd([[packadd packer.nvim]])

-- Rerun PackerCompile everytime plugins.lua is updated
cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-- Initialize pluggins
return require('packer').startup(
    function(use)
        -- Let Packer manage itself
        use { 'wbthomason/packer.nvim', opt = true }

        -- Formatting
        use 'tpope/vim-commentary'

        -- s-expressions
        use 'tpope/vim-sexp-mappings-for-regular-people'
        use 'guns/vim-sexp'
        use 'tpope/vim-repeat'
        use 'tpope/vim-surround'

        -- Themes
        use 'tanvirtin/monokai.nvim'
        use 'folke/tokyonight.nvim'

        -- Spellchecker
        -- use 'kamykn/popup-menu.nvim'
        use 'kamykn/spelunker.vim'

        -- smart line number toggling
        use 'jeffkreeftmeijer/vim-numbertoggle'

        -- edit jupyter notebooks (requires pip install jupytext)
        use {
            'goerz/jupytext.vim',
            config = function() vim.cmd("let g:jupytext_fmt = 'py'") end
        }

        -- git commands
        use 'tpope/vim-fugitive'
        -- use 'airblade/vim-gitgutter'
        use {
            'lewis6991/gitsigns.nvim',
            config = function() require('gitsigns').setup {
                    signs = {
                        add = { hl = 'GitSignsAdd', text = '+' },
                        change = { hl = 'String', text = '~' },
                        delete = { hl = 'GitSignsDelete', text = '-' },
                        topdelete = { hl = 'GitSignsDelete', text = '-' },
                        changedelete = { hl = 'CursorLineNr', text = '#' },
                        untracked = { hl = 'GitSignsAdd', text = '+' }
                    }
                }
            end
        }

        -- vim wiki
        use 'vimwiki/vimwiki'

        use {
            'jpalardy/vim-slime',
            config = function() require('plugins.slime') end
        }

        --  use 'williamboman/nvim-lsp-installer' -- Helper for installing most language servers
        -- nvim-lsp-installer is deprecated, use mason
        use {
            "williamboman/mason.nvim",
            config = function() require('plugins.mason') end
        }

        use {
            "williamboman/mason-lspconfig.nvim",
            config = function() require("mason-lspconfig").setup() end
        }

        -- LSP server
        use {
            'neovim/nvim-lspconfig',
            config = function() require('lsp.lspconfig') end
        }

        -- Treesitter
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function() require('plugins.treesitter') end,
            run = ':TSUpdate'
        }

        use {
            'nvim-treesitter/nvim-treesitter-context',
            config = function() require('treesitter-context').setup() end
        }

        -- Telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = { { 'nvim-lua/plenary.nvim' } },
            config = function() require('plugins.telescope') end,
        }
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

        -- Nvim-tree
        -- use {
        --     'kyazdani42/nvim-tree.lua',
        --     config = function() require('plugins.nvimtree') end,
        -- }
        -- Netrw
        require('plugins.netrw')

        if packer_bootstrap then
            require('packer').sync()
        end
    end
)

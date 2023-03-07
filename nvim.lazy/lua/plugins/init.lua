-- Initialize pluggins
return {
    -- themes
    'tanvirtin/monokai.nvim',

    -- git
    'tpope/vim-fugitive',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
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
    },

    -- Spellchecker
    -- 'kamykn/popup-menu.nvim'
    'kamykn/spelunker.vim',

    -- smart line number toggling
    'jeffkreeftmeijer/vim-numbertoggle',

    -- Formatting
    'tpope/vim-commentary',

    -- hylang support
    'hylang/vim-hy',
    -- racket support
    'benknoble/vim-racket',
    -- janet support
    'janet-lang/janet.vim',

    -- s-expressions
    -- 'tpope/vim-sexp-mappings-for-regular-people',
    -- 'guns/vim-sexp',
    -- 'tpope/vim-repeat',
    -- 'tpope/vim-surround',
    'Olical/conjure',
    {
        'eraserhd/parinfer-rust',
        build = 'cd ' .. vim.fn.stdpath('data') .. "/lazy/parinfer-rust" .. ' && cargo build --release'
        -- FIXME fix path to installation?
    },

    -- clojure support
    {
        'clojure-vim/vim-jack-in',
        dependencies = {
            { 'tpope/vim-dispatch' },
            { 'radenling/vim-dispatch-neovim' }
        }
    },
}




-- -- -- edit jupyter notebooks (requires pip install jupytext)
-- -- use {
-- --     'goerz/jupytext.vim',
-- --     config = function() vim.cmd("let g:jupytext_fmt = 'py'") end
-- -- }

-- -- vim wiki
-- use 'vimwiki/vimwiki'

-- -- use {
-- --     'jpalardy/vim-slime',
-- --     config = function() require('plugins.slime') end
-- -- }

-- --  use 'williamboman/nvim-lsp-installer' -- Helper for installing most language servers
-- -- nvim-lsp-installer is deprecated, use mason
-- use {
--     "williamboman/mason.nvim",
--     config = function() require('plugins.mason') end
-- }

-- use {
--     "williamboman/mason-lspconfig.nvim",
--     config = function() require("mason-lspconfig").setup() end
-- }

-- -- LSP server
-- use {
--     'neovim/nvim-lspconfig',
--     config = function() require('lsp.lspconfig') end
-- }

-- -- Treesitter
-- use {
--     'nvim-treesitter/nvim-treesitter',
--     requires = {
--         { 'p00f/nvim-ts-rainbow' },
--         { 'nvim-treesitter/playground' },
--         { 'nvim-treesitter/nvim-treesitter-textobjects' }
--     },
--     config = function() require('plugins.treesitter') end,
--     run = ':TSUpdate'
-- }

-- use {
--     'nvim-treesitter/nvim-treesitter-context',
--     config = function() require('treesitter-context').setup() end
-- }

-- -- Telescope
-- use {
--     'nvim-telescope/telescope.nvim',
--     requires = {
--         { 'nvim-lua/plenary.nvim' },
--         { "nvim-telescope/telescope-live-grep-args.nvim" },
--     },
--     config = function() require('plugins.telescope') end,
-- }
-- use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

-- -- Nvim-tree
-- -- use {
-- --     'kyazdani42/nvim-tree.lua',
-- --     config = function() require('plugins.nvimtree') end,
-- -- }
-- -- Netrw
-- require('plugins.netrw')

-- if packer_bootstrap then
--     require('packer').sync()
-- end
-- end
-- )

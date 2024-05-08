-- Initialize pluggins
return {
    -- themes
    {
        'mcchrish/zenbones.nvim',
        dependencies = {
            { 'rktjmp/lush.nvim' },
        },
        config = function()
            vim.cmd([[autocmd Colorscheme zenwritten lua require "config.customise_zenwritten"]])
            vim.cmd([[colorscheme zenwritten]])
        end
    },
    {
        'tanvirtin/monokai.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd([[colorscheme monokai]])
            -- require('monokai').setup()

            if vim.g.neovide then
                -- Colors
                local palette = require 'monokai'.classic
                vim.g.terminal_color_0 = palette.black
                vim.g.terminal_color_1 = palette.pink
                vim.g.terminal_color_2 = palette.green
                vim.g.terminal_color_3 = palette.brown
                vim.g.terminal_color_4 = palette.aqua
                vim.g.terminal_color_5 = palette.orange
                vim.g.terminal_color_6 = palette.purple
                vim.g.terminal_color_7 = palette.white
                vim.g.terminal_color_8 = palette.black
                vim.g.terminal_color_9 = palette.pink
                vim.g.terminal_color_10 = palette.green
                vim.g.terminal_color_11 = palette.brown
                vim.g.terminal_color_12 = palette.aqua
                vim.g.terminal_color_13 = palette.orange
                vim.g.terminal_color_14 = palette.purple
                vim.g.terminal_color_15 = palette.white
            end
        end,
    },

    -- git
    {
        'tpope/vim-fugitive',
        cmd = "Git"
    },
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
    {
        'kamykn/spelunker.vim',
        ft = { 'markdown', 'tex' },
    },

    -- smart line number toggling
    'jeffkreeftmeijer/vim-numbertoggle',

    -- edit jupyter notebooks
    -- {
    --     'goerz/jupytext.vim',
    --     config = function()
    --         vim.cmd("let g:jupytext_fmt = 'py'")
    --     end
    -- },

    -- Tmux Integration
    {
        'christoomey/vim-tmux-navigator',
        config = function()
            vim.g["tmux_navigator_no_mappings"] = 0
            vim.g["tmux_navigator_disable_when_zoomed"] = 1
        end
    },

    -- Formatting
    {
        'tpope/vim-commentary',
        keys = { "gcc", { "gc", mode = "v" } },
    },

    -- hylang support
    {
        'hylang/vim-hy',
        ft = 'hy',
    },
    -- racket support
    {
        'benknoble/vim-racket',
        ft = 'racket',
    },
    -- janet support
    {
        'janet-lang/janet.vim',
        ft = 'janet',
    },

    -- s-expressions
    -- 'tpope/vim-sexp-mappings-for-regular-people',
    -- 'guns/vim-sexp',
    -- 'tpope/vim-repeat',
    -- 'tpope/vim-surround',
    -- {
    --     'Olical/conjure',
    --     config = function()
    --         -- vim.g["conjure#client#racket#stdio#command"] = "xvfb-racket"
    --         vim.g["conjure#extract#tree_sitter#enabled"] = true
    --         vim.g["conjure#mapping#doc_word"] = { "<space>K" }
    --         vim.g["conjure#log#fold#enabled"] = true
    --         vim.g["conjure#log#wrap"] = true
    --     end
    -- },
    --
    { 'kassio/neoterm' },
    -- {
    --     'monkoose/nvlime',
    --     ft = "lisp",
    --     dependencies = {
    --         { 'monkoose/parsley' },
    --     },
    --     config = function ()
    --         local cmp = require('cmp')
    --         -- The nvlime plugin doesn't seem to correctly register the cmp source when
    --         -- using lazy, so we have to do it manually
    --         cmp.register_source("nvlime", require("nvlime.cmp"))
    --         cmp.setup.filetype({'lisp'}, {
    --             sources = {
    --                 {name = 'nvlime'},
    --                 {name = 'buffer', keyword_length = 3},
    --                 {name = 'path'},
    --                 {name = 'omni'},
    --             }
    --         })
    --     end

    -- },
    --
    {
        'vlime/vlime',
        ft = "lisp",
        dependencies = {
            { 'HiPhish/nvim-cmp-vlime' },
        },
        config = function()
            require('cmp').setup.filetype({ 'lisp' }, {
                sources = {
                    { name = 'vlime' },
                    { name = 'buffer', keyword_length = 3 },
                    { name = 'path' },
                    { name = 'omni' },
                }
            })

            vim.g.vlime_window_settings = {
                sldb = {
                    pos = "belowright",
                    size = nil,
                    vertical = false,
                },
                repl = {
                    pos = "belowright",
                    size = nil,
                    vertical = true,
                },
                inspector = {
                    pos = "belowright",
                    size = 12,
                    vertical = false,
                },
                mrepl = {
                    pos = "belowright",
                    size = nil,
                    vertical = true,
                },
                server = {
                    pos = "botright",
                    size = 12,
                    vertical = false,
                },
            }

            vim.g.vlime_compiler_policy = { DEBUG = 3, SPEED = 0 }
        end
    },
    {
        'eraserhd/parinfer-rust',
        build = 'cd ' .. vim.fn.stdpath('data') .. "/lazy/parinfer-rust" .. ' && cargo build --release'
    },

    -- clojure support
    {
        'clojure-vim/vim-jack-in',
        dependencies = {
            { 'tpope/vim-dispatch' },
            { 'radenling/vim-dispatch-neovim' }
        },
        ft = 'clojure'
    },

    {
        'jbyuki/instant.nvim',
        config = function()
            vim.g["instant_username"] = "rowan"
        end
    },
    {
        'sunaku/vim-dasht',
        config = function()
            vim.g.dasht_results_window = 'new'
        end
    },
    {
        'rej696/plantuml.nvim',
        config = function()
            require "plantuml".setup {
                renderer = 'text',
            }
        end,
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

-- Initialize plugins
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
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '-' },
                    topdelete = { text = '-' },
                    changedelete = { text = '#' },
                    untracked = { text = '+' }
                }
            }
        end
    },

    -- Spellchecker
    {
        'kamykn/spelunker.vim',
        ft = { 'markdown', 'tex' },
        config = function()
            vim.o.spell     = false
            vim.g.enable_spelunker_vim = 0
        end
    },

    -- smart line number toggling
    'jeffkreeftmeijer/vim-numbertoggle',

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
    -- {
    --     'hylang/vim-hy',
    --     ft = 'hy',
    -- },
    -- racket support
    -- {
    --     'benknoble/vim-racket',
    --     ft = 'racket',
    -- },
    -- janet support
    -- {
    --     'janet-lang/janet.vim',
    --     ft = 'janet',
    -- },

    -- s-expressions
    -- 'tpope/vim-sexp-mappings-for-regular-people',
    -- 'guns/vim-sexp',
    -- 'tpope/vim-repeat',
    -- 'tpope/vim-surround',
    {
        'Olical/conjure',
        config = function()
            -- vim.g["conjure#client#racket#stdio#command"] = "xvfb-racket"
            vim.g["conjure#client#python#stdio#command"] = "python3.13 -iq"
            vim.g["conjure#mapping#prefix"] = "<space>"
            vim.g["conjure#extract#tree_sitter#enabled"] = true
            vim.g["conjure#mapping#doc_word"] = { "<space>K" }
            vim.g["conjure#log#fold#enabled"] = true
            vim.g["conjure#log#wrap"] = true
        end
    },
    --
    -- { 'kassio/neoterm' },
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
    -- {
    --     'vlime/vlime',
    --     ft = "lisp",
    --     dependencies = {
    --         { 'HiPhish/nvim-cmp-vlime' },
    --     },
    --     config = function()
    --         require('cmp').setup.filetype({ 'lisp' }, {
    --             sources = {
    --                 { name = 'vlime' },
    --                 { name = 'buffer', keyword_length = 3 },
    --                 { name = 'path' },
    --                 { name = 'omni' },
    --             }
    --         })

    --         vim.g.vlime_window_settings = {
    --             sldb = {
    --                 pos = "belowright",
    --                 size = nil,
    --                 vertical = false,
    --             },
    --             repl = {
    --                 pos = "belowright",
    --                 size = nil,
    --                 vertical = true,
    --             },
    --             inspector = {
    --                 pos = "belowright",
    --                 size = 12,
    --                 vertical = false,
    --             },
    --             mrepl = {
    --                 pos = "belowright",
    --                 size = nil,
    --                 vertical = true,
    --             },
    --             server = {
    --                 pos = "botright",
    --                 size = 12,
    --                 vertical = false,
    --             },
    --         }

    --         vim.g.vlime_compiler_policy = { DEBUG = 3, SPEED = 0 }
    --     end
    -- },
    {
        'eraserhd/parinfer-rust',
        build = 'cd ' .. vim.fn.stdpath('data') .. "/lazy/parinfer-rust" .. ' && cargo build --release'
    },

    -- clojure support
    -- {
    --     'clojure-vim/vim-jack-in',
    --     dependencies = {
    --         { 'tpope/vim-dispatch' },
    --         { 'radenling/vim-dispatch-neovim' }
    --     },
    --     ft = 'clojure'
    -- },

    -- {
    --     'jbyuki/instant.nvim',
    --     config = function()
    --         vim.g["instant_username"] = "rowan"
    --     end
    -- },
    -- {
    --     'sunaku/vim-dasht',
    --     config = function()
    --         vim.g.dasht_results_window = 'new'
    --     end
    -- },
    {
        'rej696/plantuml.nvim',
        config = function()
            require "plantuml".setup {
                renderer = 'text',
            }
        end,
    },

}

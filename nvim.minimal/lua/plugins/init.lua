-- Initialize plugins
return {
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
}


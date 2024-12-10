-- Telescope configuration
return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = "make"
        }
    },
    config = function()
        local actions = require('telescope.actions')
        -- local utils = require('telescope.utils')
        -- local trouble = require('telescope.providers.telescope')
        local lga_actions = require('telescope-live-grep-args.actions')

        require('telescope').setup({
            pickers = {
                buffers = {
                    mappings = {
                        i = {
                            ['<C-x>'] = "delete_buffer",
                        },
                    },
                },
            },
            defaults = {
                sorting_strategy = "ascending",
                mappings = {
                    i = {
                        -- ['<C-n>'] = actions.move_selection_next,
                        -- ['<C-p>'] = actions.move_selection_previous,
                        ['<C-q>'] = actions.smart_send_to_qflist,
                        -- ['<C-c>'] = actions.smart_send_to_qflist,
                        ['<C-a>'] = actions.smart_add_to_qflist,
                        ['<C-s>'] = actions.file_split,
                        -- ['<C-[>'] = actions.close,
                        ['<C-c>'] = actions.close,
                        ['<C-z>'] = actions.close,
                        ['<C-o>'] = actions.cycle_history_prev,
                        ['<C-i>'] = actions.cycle_history_next,
                    },
                    n = {
                        ['<C-z>'] = actions.close,
                        ['<C-c>'] = actions.close,
                    },
                },
                layout_strategy = "flex",
                layout_config = {
                    prompt_position = "top",
                    flex = {
                        flip_columns = 170,
                    },
                },
                -- layout_config = {
                --   horizontal = {
                --     height = 47,
                --     prompt_position = "top",
                --   }
                -- }
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                live_grep_args = {
                    disable_devicons = true,
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                        },
                    },
                },
            },
        })

        require('telescope').load_extension('fzf')
    end
}

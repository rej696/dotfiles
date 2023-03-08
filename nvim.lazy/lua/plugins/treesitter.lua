-- Treesitter configuration
return {
    -- 'p00f/nvim-ts-rainbow',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',

    {
        'nvim-treesitter/playground',
        cmd = "TSPlaygroundToggle",
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                -- We must manually specify which parsers to install
                -- ensure_installed = {
                --     "bash",
                --     "c",
                --     "cpp",
                --     "json",
                --     "lua",
                --     "python",
                --     "yaml",
                --     "racket",
                --     "rust",
                --     "clojure"
                -- },
                -- rainbow = {
                --     enable = false,
                --     disable = { "c" }
                -- },
                playground = {
                    enable = true
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                                ["af"] = "@function.outer",
                                ["if"] = "@functions.inner"
                        }
                    },
                    lsp_interop = {
                        enable = true,
                        border = "single",
                        floating_preview_opts = {},
                        peek_definition_code = {
                                ["<leader>df"] = "@function.outer"
                        }
                    }
                }
            })

            vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
        end
    }
}


-- local M = {
--     'nvim-treesitter/nvim-treesitter',
--     dependencies = {
--         'p00f/nvim-ts-rainbow',
--         'nvim-treesitter/playground',
--         'nvim-treesitter/nvim-treesitter-textobjects',
--         'nvim-treesitter/nvim-treesitter-context'
--     },
--     run = ':TSUpdate'
-- }


-- function M.config()
--     require('nvim-treesitter.configs').setup({
--         highlight = {
--             enable = true,
--             additional_vim_regex_highlighting = false

--         },
--         -- We must manually specify which parsers to install
--         ensure_installed = {
--             "bash",
--             "c",
--             "cpp",
--             "json",
--             "lua",
--             "python",
--             "yaml",
--             "racket",
--             "rust",
--             "clojure"
--         },
--         rainbow = {
--             enable = false,
--             disable = { "c" }
--         },

--         playground = {
--             enable = true
--         },

--         textobjects = {
--             select = {
--                 enable = true,
--                 keymaps = {
--                     ["af"] = "@function.outer",
--                     ["if"] = "@functions.inner"
--                 }
--             },
--             lsp_interop = {
--                 enable = true,
--                 border = "single",
--                 floating_preview_opts = {},
--                 peek_definition_code = {
--                     ["<leader>df"] = "@function.outer"
--                 }
--             }
--         }
--     })
--     require('treesitter-context').setup()
-- end

-- return M

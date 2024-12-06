-- Treesitter configuration
return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require 'treesitter-context'.setup { enable = false }
            -- toggle context
            vim.api.nvim_set_keymap(
                'n', "<leader>ct", ":TSContextToggle<CR>", { noremap = true, silent = true })
        end,
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
            vim.api.nvim_set_hl(0, "@method.call", { link = "Function" })
        end
    },
}


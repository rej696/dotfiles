return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = true,
        config = function()
            -- modify lsp-zero settings here
            require('lsp-zero.settings').preset({})
        end
    },

    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-omni' },
            { 'hrsh7th/cmp-cmdline' },
            { 'saadparwaiz1/cmp_luasnip' },
        },
        config = function()
            -- modify cmp setting here

            require('lsp-zero.cmp').extend({
                set_basic_mappings = true,
                set_extra_mappings = false,
                use_luasnip = true,
            })

            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp', keyword_length = 6, group_index = 1, max_item_count = 30 },
                    { name = 'buffer',   keyword_length = 3 },
                    { name = 'path' },
                    { name = 'omni' },
                    { name = 'luasnip',  keyword_length = 2 },
                },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                }
            })

            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                completion = {
                    autocomplete = false
                },
                sources = cmp.config.sources({
                    { name = 'path' }
                }, { {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                } })
            })
        end
    },

    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'p00f/clangd_extensions.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },

        },
        config = function()
            -- Mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>sl', vim.diagnostic.setloclist, opts)

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', ':Telescope lsp_references theme=ivy disable_devicond=true<CR>', bufopts)       --vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', 'gt', ':Telescope lsp_type_definitions theme=ivy disable_devicons=true<CR>', bufopts) --vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', '<space>fe', ':Telescope diagnostics theme=ivy disable_devicons=true<CR>', bufopts)   --vim.lsp.buf.references, bufopts)
                -- vim.keymap.set('n', '<space>F', vim.lsp.buf.formatting, bufopts)
                -- vim.keymap.set('v', '<space>F', vim.lsp.buf.range_formatting, bufopts)
                vim.keymap.set('n', '<space>F', vim.lsp.buf.format, bufopts)
                vim.keymap.set('v', '<space>F', vim.lsp.buf.format, bufopts)
            end

            local clangd_on_attach = function(client, bufnr)
                -- vim.api.nvim_set_keymap('n', '<space>h', ':ClangdSwitchSourceHeader<CR>', { noremap=true, silent=true })
                on_attach(client, bufnr)
            end

            local ruff_on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                client.server_capabilities.hover = false
            end

            local lsp = require('lsp-zero')

            lsp.ensure_installed({
                'pylsp',
                'lua_ls',
                'clangd',
                -- 'hls',
                -- 'racket_langserver'
                -- 'rust_analyzer'
                -- 'ruff_lsp'
            })

            lsp.on_attach(on_attach)
            -- lsp.skip_server_setup({'clangd'})

            -- require('lspconfig.configs').perlnavigator = {
            --     default_config = {
            --         name = 'perlnavigator',
            --         cmd = 'perlnavigator',
            --         filetypes = { 'perl' },
            --         root_dir = require 'lspconfig.util'.root_pattern('.git'),
            --     }
            -- }
            require('lspconfig')['lua_ls'].setup(lsp.nvim_lua_ls())
            require('lspconfig')['gopls'].setup({})
            require('lspconfig')['zls'].setup({})
            -- require('lspconfig')['perlnavigator'].setup({
                -- perlnavigator = {
                --     perlPath = 'perl',
                --     enableWarnings = true,
                --     perltidyProfile = '',
                --     perlcriticProfile = '',
                --     perlcriticEnabled = true,
                -- },
            -- })
            require('lspconfig')['racket_langserver'].setup {
                on_attach = on_attach,
                cmd = {
                    "xvfb-run", -- For running inside WSL
                    "racket",
                    "--lib",
                    "racket-langserver"
                },
            }
            -- require('lspconfig')['ruff-lsp'].setup {
            --     on_attach = ruff_on_attach,
            -- }
            require('lspconfig')['clangd'].setup {
                on_attach = clangd_on_attach,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--enable-config",
                    "--offset-encoding=utf-16",
                    "--query-driver=/usr/local/bin/arm-none-eabi-g*", 
                },
            }
            require('clangd_extensions').setup {
            }

            lsp.setup()
        end
    },
    {
        "dhananjaylatkar/cscope_maps.nvim",
        opts = {
            disable_maps = true,
            cscope = {
                picker = "telescope",
                skip_picker_for_single_result = true,
            }
        }
    },

    -- {
    --     "rej696/calltree.nvim",
    --     dependencies = {
    --         "dhananjaylatkar/cscope_maps.nvim"
    --     },
    --     opts = {
    --         prefix = "<leader>o",
    --         tree_style = "brief",
    --     },
    -- }
}

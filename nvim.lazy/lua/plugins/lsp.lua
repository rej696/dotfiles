return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch ='v2.x',
        lazy = true,
        config = function()
            -- modify lsp-zero settings here
            require('lsp-zero.settings').preset({})
        end
    },

    {
        'zbirenbaum/copilot.lua',
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true
                },
                panel = {
                    enabled = true,
                    auto_refresh = true
                },
                copilot_node_command = '/home/rowan/.nvm/versions/node/v17.9.1/bin/node'
            })
        end
    },
    -- {
    --     'zbirenbaum/copilot-cmp',
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end
    -- },

    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-omni'},
            {'hrsh7th/cmp-cmdline'},
            {'saadparwaiz1/cmp_luasnip'},
        },
        config = function()
            -- modify cmp setting here

            require('lsp-zero.cmp').extend({
                set_basic_mappings = true,
                set_extra_mappings = false,
                use_luasnip = true,
            })

            local cmp = require('cmp')
            -- local cmp_action = require('lsp-zero.cmp').action()

            cmp.setup({
                sources = {
                    -- {name = "copilot"},
                    {name = 'nvim_lsp'},
                    {name = 'buffer', keyword_length = 3},
                    {name = 'path'},
                    {name = 'omni'},
                    {name = 'luasnip', keyword_length = 2},
                },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<Tab>'] = cmp.mapping.confirm({select = true}),
                    -- ['<Tab>'] = cmp_action.luasnip_supertab(),
                    -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                    ['<CR>'] = cmp.mapping.confirm({select = false}),
                }
            })

            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    {name = 'buffer'}
                }
            })
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                completion = {
                    autocomplete = false
                },
                sources = cmp.config.sources({
                    {name = 'path'}
                }, {{
                    name = 'cmdline',
                    option = {
                        ignore_cmds = {'Man', '!'}
                    }
                }})
            })
        end
    },

    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'p00f/clangd_extensions.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
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
                vim.keymap.set('n', 'gr', ':Telescope lsp_references theme=ivy disable_devicond=true<CR>', bufopts) --vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', 'gt', ':Telescope lsp_type_definitions theme=ivy disable_devicons=true<CR>', bufopts) --vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', '<space>fe', ':Telescope diagnostics theme=ivy disable_devicons=true<CR>', bufopts) --vim.lsp.buf.references, bufopts)
                -- vim.keymap.set('n', '<space>F', vim.lsp.buf.formatting, bufopts)
                -- vim.keymap.set('v', '<space>F', vim.lsp.buf.range_formatting, bufopts)
                vim.keymap.set('n', '<space>F', vim.lsp.buf.format, bufopts)
                vim.keymap.set('v', '<space>F', vim.lsp.buf.format, bufopts)
            end

            local clangd_on_attach = function(client, bufnr)
                require('clangd_extensions.inlay_hints').setup_autocmd()
                require('clangd_extensions.inlay_hints').set_inlay_hints()
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

            require('lspconfig')['lua_ls'].setup(lsp.nvim_lua_ls())
            require('lspconfig')['racket_langserver'].setup {
                on_attach = on_attach,
                cmd = {
                    "xvfb-run", -- For running inside WSL
                    "racket",
                    "--lib",
                    "racket-langserver"
                },
            }
            require('lspconfig')['ruff_lsp'].setup {
                on_attach = ruff_on_attach,
            }
            require('lspconfig')['clangd'].setup {
                on_attach = clangd_on_attach,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--enable-config",
                    "--offset-encoding=utf-16",
                },
            }
            require('clangd_extensions').setup {
                inlay_hints = {
                    only_current_line = true,
                }
            }

            lsp.setup()

        end
    }
}

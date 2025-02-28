return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
    },
    config = function()
        -- reserve space in the gutter for signs
        vim.opt.signcolumn = 'yes'

        -- setup cmp, must be done before running an lsp
        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        -- configure lsp keymaps
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function (event)
                local opts = {}
                local bufopts = {buffer = event.buf}

                vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                vim.keymap.set('n', '<space>sl', vim.diagnostic.setloclist, opts)

                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
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
                vim.keymap.set({'n', 'x'}, '<space>F', vim.lsp.buf.format, bufopts)
                vim.keymap.set('v', '<space>F', vim.lsp.buf.format, bufopts)

            end,
        })

        require('mason').setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        require('mason-lspconfig').setup({
            ensure_installed = {'basedpyright', 'ruff', 'lua_ls', 'clangd'},
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT',
                                },
                                diagnostics = {
                                    globals = {'vim'},
                                },
                                workspace = {
                                    library = {vim.env.VIMRUNTIME},
                                },
                            },
                        },
                    })
                end,
                clangd = function()
                    require('lspconfig').clangd.setup({
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--clang-tidy",
                            "--enable-config",
                            "--offset-encoding=utf-16",
                            "--query-driver=/usr/local/bin/arm-none-eabi-g*",
                        },
                    })
                end,
                ruff = function()
                    require('lspconfig').ruff.setup({
                    })
                end,
                basedpyright = function()
                    require('lspconfig').basedpyright.setup({
                        settings = {
                            basedpyright = {
                                analysis = {
                                    ignore = { '*' }, -- don't perform any analysis
                                    typeCheckingMode = "off",
                                },
                            },
                        },
                    })
                end,
            },
        })

        -- autocompletion config
        local cmp = require('cmp')

        cmp.setup({
            sources = {
                { name = 'nvim_lsp', keyword_length = 6, group_index = 1, max_item_count = 30 },
                { name = 'buffer',   keyword_length = 3 },
                { name = 'path' },
                { name = 'omni' },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
            }),
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
        })

    end
}

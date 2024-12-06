return {
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

            local cmp = require('cmp')

            cmp.setup({
                sources = {
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
}

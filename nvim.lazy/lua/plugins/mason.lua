return {
    --  use 'williamboman/nvim-lsp-installer' -- Helper for installing most language servers
    -- nvim-lsp-installer is deprecated, use mason
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            config = true
            -- config = function() require("mason-lspconfig").setup() end
        },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        },
        -- cmd = { "Mason", "LspInstall" } -- Mason is needed to add lsp binaries to path
    },
}

-- -- TODO make plugin file
-- --  use 'williamboman/nvim-lsp-installer' -- Helper for installing most language servers
-- -- nvim-lsp-installer is deprecated, use mason
-- {
--     "williamboman/mason.nvim",
--     config = function() require('plugins.mason') end
-- },

-- {
--     "williamboman/mason-lspconfig.nvim",
--     config = function() require("mason-lspconfig").setup() end
-- },
-- require("mason").setup({
--     ui = {
--         icons = {
--             package_installed = "✓",
--             package_pending = "➜",
--             package_uninstalled = "✗"
--         }
--     }
-- })

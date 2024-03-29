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
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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
    -- vim.api.nvim_set_keymap('n', '<space>h', ':ClangdSwitchSourceHeader<CR>', { noremap=true, silent=true })
    on_attach(client, bufnr)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
require('lspconfig')['pylsp'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['lua_ls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            runtime = {
                -- LuaJIT in the case of Neovim
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}
require('lspconfig')['hls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['clangd'].setup {
    on_attach = clangd_on_attach,
    flags = lsp_flags,
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
    },
}
require('lspconfig')['ltex'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['racket_langserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    cmd = {
        "xvfb-run", -- For running inside WSL
        "racket",
        "--lib",
        "racket-langserver"
    },
}

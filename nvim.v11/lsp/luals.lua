return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.git', '.luarc.json' },
    settings = {
        Lua = {
            runtime = { 'LuaJIT', },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = { vim.env.VIMRUNTIME },
            },
        },
    }

}

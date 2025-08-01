vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufopts = { buffer = ev.buf }
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
        vim.keymap.set({ 'n', 'v', 'x' }, '<leader>F', vim.lsp.buf.format, bufopts)
    end,
})

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>F', vim.lsp.buf.format, bufopts)

vim.lsp.set_log_level("off")

-- Disable inline error messages
vim.diagnostic.config {
  virtual_text = false,
  underline = false,            -- Keep error underline
  signs = true,                -- Keep gutter signs
}

vim.lsp.enable({'clangd', 'luals', 'ruff', 'basedpyright',})

-- Stop LSP from overriding ctags
vim.cmd [[set tagfunc=]]

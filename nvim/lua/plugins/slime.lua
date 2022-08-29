-- vim.api.nvim_exec([[
-- let g:slime_target = "tmux"
-- let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
-- ]],
-- false)

vim.api.nvim_exec([[

nnoremap <leader>sc <Plug>SlimeParagraphSend<C-w><C-w>A<CR><C-\><C-n><C-w><C-w>
xnoremap <leader>ss <Plug>SlimeRegionSend<C-w><C-w>A<CR><C-\><C-n><C-w><C-w>
nnoremap <leader>ss v%<Plug>SlimeRegionSend<C-w><C-w>A<CR><C-\><C-n><C-w><C-w>%

nnoremap <leader>st :sp<CR>:term<CR><C-\><C-n><C-w><C-w>:SlimeConfig<CR><CR><C-w><C-W>
nnoremap <leader>sv :vs<CR>:term<CR><C-\><C-n><C-w><C-w>:SlimeConfig<CR><CR><C-w><C-W>
tnoremap <leader>si <C-\><C-n>:echo &channel<CR>A
nnoremap <leader>si :echo &channel<CR>

let g:slime_target = "neovim"
]],
false)

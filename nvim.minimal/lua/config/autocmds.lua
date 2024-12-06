-- Remove trailing whitespace
vim.cmd [[autocmd BufWritePre * %s/\s\+$//e ]]

-- Swap folder
vim.cmd('command! ListSwap split | enew | r !ls -l ~/.local/share/nvim/swap')
vim.cmd('command! CleanSwap !rm -rf ~/.local/share/nvim/swap/')

-- Open help tags
vim.cmd('command! HelpTags Telescope help_tags')

-- Grep
vim.api.nvim_exec ([[
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

function! Grep(...)
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction
]],
false)

vim.cmd('command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr Grep(<f-args>)')
vim.cmd('command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)')

vim.api.nvim_exec ([[
" automatically convert :grep into Grep
cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

" automatically open quickfix list whenever cgetexpr is called
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
]],

false)

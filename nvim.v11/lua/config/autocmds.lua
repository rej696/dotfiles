-- Remove trailing whitespace
vim.cmd([[
function! AutoTrimWhitespaceEnable()
    if !exists('#AutoTrimWhitespace#BufWritePre')
        augroup AutoTrimWhitespace
            autocmd!
            autocmd BufWritePre * %s/\s\+$//e
        augroup END
    endif
endfunction

function! AutoTrimWhitespaceDisable()
    if exists('#AutoTrimWhitespace#BufWritePre')
        augroup AutoTrimWhitespace
            autocmd!
        augroup END
    endif
endfunction
call AutoTrimWhitespaceEnable()

command! AutoTrimWhitespaceEnable call AutoTrimWhitespaceEnable()
command! AutoTrimWhitespaceDisable call AutoTrimWhitespaceDisable()
]]
)

-- Swap folder
vim.cmd('command! ListSwap split | enew | r !ls -l ~/.local/share/nvim/swap')
vim.cmd('command! CleanSwap !rm -rf ~/.local/share/nvim/swap/')

-- Open help tags
vim.cmd('command! HelpTags Telescope help_tags')

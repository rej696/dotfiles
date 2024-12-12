" from https://begriffs.com/posts/2019-07-19-history-use-vim.html

if !executable('xxd')
    finish
endif

setlocal binary noendofline
silent %!xxd -g 1
%s/\r$//e

augroup ftplugin-xxd
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> let b:xxd_cursor = getpos('.')
    autocmd BufWritePre <buffer> silent %!xxd -r

    autocmd BufWritePost <buffer> silent %!xxd -g 1
    autocmd BufWritePost <buffer> %s/\r$//e
    autocmd BufWritePost <buffer> setlocal nomodified
    autocmd BufWritePost <buffer> call setpos('.', b:xxd_cursor) | unlet b:xxd_cursor
    autocmd TextChanged,InsertLeave <buffer> let b:xxd_cursor = getpos('.')
    autocmd TextChanged,InsertLeave <buffer> silent %!xxd -r
    autocmd TextChanged,InsertLeave <buffer> silent %!xxd -g 1
    autocmd TextChanged,InsertLeave <buffer> call setpos('.', b:xxd_cursor) | unlet b:xxd_cursor
augroup END

let b:undo_ftplugin = 'setl bin< eol< | execute "au! ftplugin-xxd * <buffer>" | execute "silent %!xxd -r"'

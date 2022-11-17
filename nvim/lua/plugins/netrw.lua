-- " netrw commands
-- " gh : toggle hidden files
-- " return : open file
-- " %: create a new file
-- " d: create a directory
-- " -: move up a directory
-- " p: Preview the file
-- " s: select sorting style
-- " r: reverse sorting order
-- " R: rename highlighted file/directory
-- " t: open in newtab


-- " netrw directory browser settings
-- "let g:netrw_liststyle=0 "thin view (- to go up a directory)
-- "let g:netrw_browse_split=4 "open new file in pr:evious window
vim.g.netrw_winsize=25 --set default width to 25%
-- vim.g.netrw_keepdir=0 -- sync current dir with browsing dir
-- "let g:netrw_altv=1
vim.g.netrw_banner=0 --hide banner
-- vim.g.netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

-- "override overloading netrw settings to enable line numbers
vim.g.netrw_bufsettings='noma nomod nu nobl nowrap ro'

local Utils = require('utils')

local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap
local nmap = Utils.nmap
local xmap = Utils.xmap

vim.g.mapleader = " "
vim.g.maplocalleader = "  "

-- Insert unicode lambda
inoremap("<C-l>", "<C-v>u03BB")

nnoremap("<leader>ob", ":!fd -e c -e h | xargs cscope -b <CR>")
nnoremap("<leader>ot", ":!fd -e c -e h | ctags -L - <CR>")

-- Toggle Source and header
nnoremap("<leader>gh", "<Cmd>ClangdSwitchSourceHeader<CR>")
nnoremap("<leader>th", "<Cmd>ClangdToggleInlayHints<CR>")

-- Trim whitespace
nnoremap("<leader>tr", ":%s/\\s\\+$//e<CR>")
vnoremap("<leader>tr", ":s/\\s\\+$//e<CR>")
nnoremap("<leader>te", ":AutoTrimWhitespaceEnable<CR>")
nnoremap("<leader>td", ":AutoTrimWhitespaceDisable<CR>")

-- Centre page after pgdn/up
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Centre page after search
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
nnoremap("*", "*zz")

-- Remap Splits
nnoremap("<leader>v", ":vsplit<CR>")
nnoremap("<leader>sp", ":split<CR>")
nnoremap("<A-Left>", ":<C-U>TmuxNavigateLeft<CR>")
nnoremap("<A-Down>", ":<C-U>TmuxNavigateDown<CR>")
nnoremap("<A-Up>", ":<C-U>TmuxNavigateUp<CR>")
nnoremap("<A-Right>", ":<C-U>TmuxNavigateRight<CR>")
nnoremap("<A-h>", ":<C-U>TmuxNavigateLeft<CR>")
nnoremap("<A-j>", ":<C-U>TmuxNavigateDown<CR>")
nnoremap("<A-k>", ":<C-U>TmuxNavigateUp<CR>")
nnoremap("<A-l>", ":<C-U>TmuxNavigateRight<CR>")
nnoremap("<A-p>", ":<C-U>TmuxNavigatePrevious<CR>")
-- nnoremap("<A-h>", "<C-W><h>")
-- nnoremap("<A-j>", "<C-W><j>")
-- nnoremap("<A-k>", "<C-W><k>")
-- nnoremap("<A-l>", "<C-W><l>")

-- List Buffer then select
nnoremap("<leader>b", ":ls<CR>:b<Space>")

-- Delete Current Buffer
nnoremap("<leader>x", ":bd<CR>")
nnoremap("[b", ":bnext<CR>")
nnoremap("]b", ":bprevious<CR>")

-- Buffer Navigation
nnoremap("<A-Home>", ":tabp<CR>")
nnoremap("<A-End>", ":tabn<CR>")
nnoremap("[p", ":tabp<CR>")
nnoremap("]p", ":tabn<CR>")

-- tag navigation
nnoremap("[t", ":tp<CR>")
nnoremap("]t", ":tn<CR>")
nnoremap("<leader>tn", ":tn<CR>")
nnoremap("<leader>tp", ":tp<CR>")
nnoremap("<leader>ts", ":ts<CR>")

-- Terminal Remapping
tnoremap("<Esc>", "<C-\\><C-n>")

-- Quickfix list
nnoremap("<leader>cl", ":cwindow<CR>")
nnoremap("<leader>co", ":copen<CR>")
nnoremap("<leader>cc", ":cclose<CR>")
nnoremap("]q", ":cnext<CR>")
nnoremap("[q", ":cprevious<CR>")

-- Location list
nnoremap("<leader>ll", ":lwindow<CR>")
nnoremap("<leader>lo", ":lopen<CR>")
nnoremap("<leader>lc", ":lclose<CR>")
nnoremap("]l", ":lnext<CR>")
nnoremap("[l", ":lprevious<CR>")

-- Fugitive
nnoremap("<leader>G", ":G<CR>")

-- Show line diagnostics
nnoremap("<leader>d", '<Cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>')

-- Open local diagnostics in local list
-- nnoremap("<leader>D", "<Cmd>lua vim.diagnostic.setloclist()<CR>")

-- Open all project diagnostics in quickfix list
-- nnoremap("<leader><A-d>", "<Cmd>lua vim.diagnostic.setqflist()<CR>")

-- *** LSP keymaps ***
-- gD         go to declaration
-- gd         go to definition
-- gi         go to implementation
-- gr         go to references (telescope)
-- gt         go to type definitions (telescope) (needs fixing?)
-- <leader>D  go to type definition
-- K          hover
-- ^k         signature_help
-- <leader>rs rename
-- <leader>ca code action
-- <space>fe  find errors (list diagnostics in file in telescope)
-- <space>F   format

-- Fuzzy find files
nnoremap("<leader>fi", ":find **/")
nnoremap("<leader>ff", "<Cmd>Telescope find_files disable_devicons=true<CR>")
nnoremap("<leader>fa", "<Cmd>Telescope find_files disable_devicons=true hidden=true no_ignore=true<CR>")
nnoremap("<leader>fb", "<Cmd>Telescope buffers disable_devicons=true<CR>")
-- nnoremap("<leader>fg", "<Cmd>Telescope live_grep disable_devicons=true<CR>")
nnoremap("<leader>fg", "<Cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
-- nnoremap("<leader>fg", '<Cmd>Telescope grep_string only_sort_text=true search=""<CR>')
nnoremap("<leader>fw", "<Cmd>lua require('telescope.builtin').grep_string{search = vim.fn.expand('<cword>')}<CR>")
nnoremap("<leader>fh", "<Cmd>Telescope help_tags disable_devicons=true<CR>")
nnoremap("<leader>ft", "<Cmd>Telescope builtin<CR>")
nnoremap("<leader>fd", "<Cmd>Telescope diagnostics disable_devicons=true<CR>")
nnoremap("<leader>fp", "<Cmd>Telescope resume disable_devicons=true<CR>")
nnoremap("<leader>fr", "<Cmd>Telescope resume disable_devicons=true<CR>")

nnoremap("<leader>fu", "<Cmd>Telescope undo disable_devicons=true<CR>")

-- Git
nnoremap("<leader>gp", "<Cmd>Gitsigns preview_hunk_inline<CR>")
nnoremap("]g", "<Cmd>Gitsigns next_hunk<CR>")
nnoremap("[g", "<Cmd>Gitsigns prev_hunk<CR>")
nnoremap("<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>")
nnoremap("<leader>gl", "<Cmd>Gitsigns blame_line<CR>")
nnoremap("<leader>ga", "<Cmd>Gitsigns stage_hunk<CR>")
nnoremap("<leader>gu", "<Cmd>Gitsigns undo_stage_hunk<CR>")
nnoremap("<leader>gb", "<Cmd>Git blame<CR>")
nnoremap("<leader>gs", "<Cmd>Telescope git_status disable_devicons=true<CR>")
-- nnoremap("<leader>gfb", "<Cmd>Telescope git_branches disable_devicons=true<CR>")
nnoremap("Zl", "<Cmd>Telescope spell_suggest theme=cursor disable_devicons=true<CR>")
nnoremap("z=", "<Cmd>Telescope spell_suggest theme=cursor disable_devicons=true<CR>")
nnoremap("Ze", "<Cmd>setlocal spell<CR>")
nnoremap("Zd", "<Cmd>setlocal nospell<CR>")

-- Close window but not vim
nnoremap("<leader>q", ":close<CR>")

-- Grep Command
nnoremap("<leader>rg", ":Grep<Space>")

-- VimGrep
nnoremap("<leader>/", ":vimgrep<Space>")

-- Don't lose contents of yank register on visual select and paste
xnoremap("<leader>p", "\"_dP")
nnoremap("<leader>p", "\"+p")
nnoremap("<leader>P", "\"+P")

-- Yank to system clipboard, delete to _ register
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nnoremap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")
nnoremap("<leader>D", "\"_D")

-- Send to terminal
-- xmap("<leader>e", "<Plug>(neoterm-repl-send)")
-- nmap("<leader>e", "<Plug>(neoterm-repl-send)")
-- nmap("<leader>ee", "<leader>ea(")
-- nmap("<leader>E", "<Plug>(neoterm-repl-send-line)")
-- nnoremap("<leader>lv", ":vert bo Ttoggle<CR>")
-- nnoremap("<leader>ls", ":bo Ttoggle<CR>")


-- Dasht documentations
-- nnoremap("<leader>K", ":call Dasht(dasht#cursor_search_terms())<CR>")
-- vnoremap("<leader>K", "y:<C-U>callDasht(getreg(0))<CR>")

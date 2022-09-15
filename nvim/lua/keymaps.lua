local Utils = require('utils')

local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Toggle Source and header
nnoremap("<leader>h", "<Cmd>ClangdSwitchSourceHeader<CR>")

-- Remap Splits
nnoremap("<leader>v", ":vsplit<CR>")
nnoremap("<leader>sp", ":split<CR>")
nnoremap("<A-Left>", "<C-W><Left>")
nnoremap("<A-Down>", "<C-W><Down>")
nnoremap("<A-Up>", "<C-W><Up>")
nnoremap("<A-Right>", "<C-W><Right>")
nnoremap("<A-h>", "<C-W><h>")
nnoremap("<A-j>", "<C-W><j>")
nnoremap("<A-k>", "<C-W><k>")
nnoremap("<A-l>", "<C-W><l>")

-- Toggle File explorer
nnoremap("<leader>e", "<Cmd>NvimTreeToggle<CR>")
-- nnoremap("<leader>e", ":Lex<CR>")

-- List Buffer then select
nnoremap("<leader>b", ":ls<CR>:b<Space>")

-- Delete Current Buffer
nnoremap("<leader>x", ":bd<CR>")

-- Buffer Navigation
nnoremap("<A-Home>", ":bprev<CR>")
nnoremap("<A-End>", ":bnext<CR>")

-- Terminal Remapping
tnoremap("<Esc>", "<C-\\><C-n>")

-- Quickfix list
nnoremap("<leader>cl", ":cwindow<CR>")
nnoremap("<leader>co", ":copen<CR>")
nnoremap("<leader>cc", ":cclose<CR>")

-- Location list
nnoremap("<leader>ll", ":lwindow<CR>")
nnoremap("<leader>lo", ":lopen<CR>")
nnoremap("<leader>lc", ":lclose<CR>")

-- Fugitive
nnoremap("<leader>G", ":G<CR>")

-- Show line diagnostics
nnoremap("<leader>d", '<Cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>')

-- Open local diagnostics in local list
nnoremap("<leader>D", "<Cmd>lua vim.diagnostic.setloclist()<CR>")

-- Open all project diagnostics in quickfix list
nnoremap("<leader><A-d>", "<Cmd>lua vim.diagnostic.setqflist()<CR>")

-- Fuzzy find files
nnoremap("<leader>fi", ":find **/*")
nnoremap("<leader>ff", "<Cmd>Telescope find_files disable_devicons=true<CR>")
nnoremap("<leader>fa", "<Cmd>Telescope find_files disable_devicons=true hidden=true no_ignore=true<CR>")
nnoremap("<leader>fb", "<Cmd>Telescope buffers disable_devicons=true<CR>")
nnoremap("<leader>fg", "<Cmd>Telescope live_grep disable_devicons=true<CR>")
nnoremap("<leader>fw", "<Cmd>lua require('telescope.builtin').grep_string{search = vim.fn.expand('<cword>')}<CR>")
nnoremap("<leader>fh", "<Cmd>Telescope help_tags disable_devicons=true<CR>")
nnoremap("<leader>ft", "<Cmd>Telescope<CR>")
nnoremap("<leader>gs", "<Cmd>Telescope git_status disable_devicons=true<CR>")
nnoremap("<leader>gb", "<Cmd>Telescope git_branches disable_devicons=true<CR>")

-- Close window but not vim
nnoremap("<leader>q", ":close<CR>")

-- Grep Command
nnoremap("<leader>gr", ":Grep<Space>")

-- VimGrep
nnoremap("<leader>/", ":vimgrep<Space>")

-- Don't lose contents of yank register on visual select and paste
xnoremap("<leader>p", "\"_dP")

-- Yank to system clipboard, delete to _ register
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nnoremap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")
nnoremap("<leader>D", "\"_D")

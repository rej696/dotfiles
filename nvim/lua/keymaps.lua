local Utils = require('utils')

local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
nnoremap("<leader>f", ":find **/*")

-- Close window but not vim
nnoremap("<leader>q", ":close<CR>")

-- Grep Command
nnoremap("<leader>g", ":Grep<Space>")

-- VimGrep
nnoremap("<leader>/", ":vimgrep<Space>")

local Utils = require('utils')

local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap
local nmap = Utils.nmap
local xmap = Utils.xmap

local opts = {noremap = true, silent = true}

vim.keymap.set("n", "<leader>ob", ":!fd -e c -e h | xargs cscope -b <CR>", opts)
vim.keymap.set("n", "<leader>ot", ":!fd -e c -e h | ctags -L - <CR>", opts)

-- Toggle Source and header
vim.keymap.set("n", "<leader>gh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
vim.keymap.set("n", "<leader>th", "<Cmd>ClangdToggleInlayHints<CR>", opts)

-- Trim whitespace
vim.keymap.set({"n", "v"}, "<leader>tr", ":%s/\\s\\+$//e<CR>", opts)
vim.keymap.set("n", "<leader>te", ":AutoTrimWhitespaceEnable<CR>", opts)
vim.keymap.set("n", "<leader>td", ":AutoTrimWhitespaceDisable<CR>", opts)

-- Centre page after pgdn/up
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Centre page after search
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "*", "*zz", opts)

-- Remap Splits
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", opts)
vim.keymap.set("n", "<leader>sp", ":split<CR>", opts)
vim.keymap.set("n", "<A-Left>", ":<C-U>TmuxNavigateLeft<CR>", opts)
vim.keymap.set("n", "<A-Down>", ":<C-U>TmuxNavigateDown<CR>", opts)
vim.keymap.set("n", "<A-Up>", ":<C-U>TmuxNavigateUp<CR>", opts)
vim.keymap.set("n", "<A-Right>", ":<C-U>TmuxNavigateRight<CR>", opts)
vim.keymap.set("n", "<A-h>", ":<C-U>TmuxNavigateLeft<CR>", opts)
vim.keymap.set("n", "<A-j>", ":<C-U>TmuxNavigateDown<CR>", opts)
vim.keymap.set("n", "<A-k>", ":<C-U>TmuxNavigateUp<CR>", opts)
vim.keymap.set("n", "<A-l>", ":<C-U>TmuxNavigateRight<CR>", opts)
vim.keymap.set("n", "<A-p>", ":<C-U>TmuxNavigatePrevious<CR>", opts)
-- vim.keymap.set("n", "<A-h>", "<C-W><h>", opts)
-- vim.keymap.set("n", "<A-j>", "<C-W><j>", opts)
-- vim.keymap.set("n", "<A-k>", "<C-W><k>", opts)
-- vim.keymap.set("n", "<A-l>", "<C-W><l>", opts)

-- List Buffer then select
vim.keymap.set("n", "<leader>b", ":ls<CR>:b<Space>", opts)

-- Delete Current Buffer
vim.keymap.set("n", "<leader>x", ":bd<CR>", opts)
vim.keymap.set("n", "[b", ":bnext<CR>", opts)
vim.keymap.set("n", "]b", ":bprevious<CR>", opts)

-- Buffer Navigation
vim.keymap.set("n", "<A-Home>", ":tabp<CR>", opts)
vim.keymap.set("n", "<A-End>", ":tabn<CR>", opts)

-- tag navigation
vim.keymap.set("n", "<leader>ts", ":ts<CR>", opts)

-- Terminal Remapping
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Quickfix list
vim.keymap.set("n", "<leader>cl", ":cwindow<CR>", opts)
vim.keymap.set("n", "<leader>co", ":copen<CR>", opts)
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", opts)

-- Location list
vim.keymap.set("n", "<leader>ll", ":lwindow<CR>", opts)
vim.keymap.set("n", "<leader>lo", ":lopen<CR>", opts)
vim.keymap.set("n", "<leader>lc", ":lclose<CR>", opts)

-- Show line diagnostics
vim.keymap.set("n", "<leader>gd", vim.diagnostic.open_float, opts)

-- Fuzzy find files
vim.keymap.set("n", "<leader>fi", ":find **/", opts)
vim.keymap.set("n", "<leader>ff", FzfLua.files, opts)
vim.keymap.set("n", "<leader>fb", FzfLua.buffers, opts)
vim.keymap.set("n", "<leader>fg", FzfLua.live_grep, opts)
vim.keymap.set("n", "<leader>fw", FzfLua.grep_cword, opts)
vim.keymap.set("n", "<leader>gs", FzfLua.git_status, opts)
vim.keymap.set("n", "<leader>fr", FzfLua.resume, opts)
vim.keymap.set("n", "<leader>fh", FzfLua.help_tags, opts)
vim.keymap.set("n", "<leader>ft", FzfLua.builtin, opts)
vim.keymap.set("n", "<leader>fd", FzfLua.diagnostics_workspace, opts)

-- Git
vim.keymap.set("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk_inline<CR>", opts)
vim.keymap.set("n", "]g", "<Cmd>Gitsigns next_hunk<CR>", opts)
vim.keymap.set("n", "[g", "<Cmd>Gitsigns prev_hunk<CR>", opts)
vim.keymap.set("n", "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>", opts)
vim.keymap.set("n", "<leader>gl", "<Cmd>Gitsigns blame_line<CR>", opts)
vim.keymap.set("n", "<leader>ga", "<Cmd>Gitsigns stage_hunk<CR>", opts)
vim.keymap.set("n", "<leader>gu", "<Cmd>Gitsigns undo_stage_hunk<CR>", opts)
vim.keymap.set("n", "<leader>gb", "<Cmd>Git blame<CR>", opts)

vim.keymap.set("n", "Zl", "<Cmd>FzfLua spell_suggest<CR>")
vim.keymap.set("n", "z=", "<Cmd>FzfLua spell_suggest<CR>")
vim.keymap.set("n", "Ze", "<Cmd>setlocal spell<CR>", opts)
vim.keymap.set("n", "Zd", "<Cmd>setlocal nospell<CR>", opts)

-- Close window but not vim
vim.keymap.set("n", "<leader>q", ":close<CR>", opts)

-- Don't lose contents of yank register on visual select and paste
vim.keymap.set("x", "<leader>p", "\"_dP", opts)
vim.keymap.set("n", "<leader>p", "\"+p", opts)
vim.keymap.set("n", "<leader>P", "\"+P", opts)

-- Yank to system clipboard, delete to _ register
vim.keymap.set("n", "<leader>y", "\"+y", opts)
vim.keymap.set("v", "<leader>y", "\"+y", opts)
vim.keymap.set("n", "<leader>Y", "\"+Y", opts)

vim.keymap.set("n", "<leader>d", "\"_d", opts)
vim.keymap.set("v", "<leader>d", "\"_d", opts)
vim.keymap.set("n", "<leader>D", "\"_D", opts)

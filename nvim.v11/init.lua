
-- nvim vscode configuration
if vim.g.vscode then
    local vscode = require "vscode"
    vim.o.statusline = [[%<%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P]]
    -- vscode.update_config("editor.lineNumbers", "relative", "global")
    vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
        pattern = {'*'},
        callback = function()
            vim.api.nvim_buf_create_user_command(0, "Oil", function() vscode.action('oil-code.open') end, {})
            vim.api.nvim_buf_create_user_command(0, "Ex", function() vscode.action('oil-code.open') end, {})
            vim.api.nvim_buf_create_user_command(0, "Term", function() vscode.action('oil-code.open') end, {})
            vim.keymap.set('n', '<space>tt', function() vscode.action('workbench.action.terminal.toggleTerminal') end, {})
            vim.keymap.set('n', '<space>to', function() vscode.action('workbench.action.output.toggleOutput') end, {})
            -- vim.keymap.set('n', '<space>to', function() vscode.action('workbench.action.output.show.extension-output-asvetliakov.vscode-neovim-#31-vscode-neovim messages') end, {})
            -- vim.keymap.set('n', '<space>ff', function() vscode.action('workbench.action.quickOpen') end, {})
            vim.keymap.set('n', '<space>ff', function() vscode.action('find-it-faster.findFiles') end, {})
            vim.keymap.set('n', '<space>fg', function() vscode.action('find-it-faster.findWithinFiles') end, {})
            vim.keymap.set('n', '<space>ft', function() vscode.action('workbench.action.showCommands') end, {})
            -- vim.keymap.set('n', '<space>fg', function() vscode.action('workbench.action.quickTextSearch') end, {})
            vim.keymap.set('n', '<space>fb', function() vscode.action('workbench.action.showAllEditors') end, {})
            -- vim.keymap.set('n', '<space>fw', function() vscode.action('workbench.action.findInFiles', { args = { query = vim.fn.expand('<cword>') } }) end, {})
            vim.keymap.set('n', '<space>fw', function() vscode.action('workbench.action.quickTextSearch', { args = { query = vim.fn.expand('<cword>') } }) end, {})
            -- vim.keymap.set('n', '<space>q', function() vscode.action('workbench.action.closeActiveEditor') end, {})
            vim.keymap.set('n', '<space>q', function() vscode.action('workbench.action.closeGroup') end, {})
            vim.keymap.set('n', '<space>sp', function() vscode.action('workbench.action.splitEditorDown') end, {})
            vim.keymap.set('n', '<space>v', function() vscode.action('workbench.action.splitEditorRight') end, {})
            vim.keymap.set('n', '<space>sv', function() vscode.action('workbench.action.splitEditorRight') end, {})
            vim.keymap.set('n', '<space>s<left>', function() vscode.action('workbench.action.moveActiveEditorGroupLeft') end, {})
            vim.keymap.set('n', '<space>s<down>', function() vscode.action('workbench.action.moveActiveEditorGroupDown') end, {})
            vim.keymap.set('n', '<space>s<up>', function() vscode.action('workbench.action.moveActiveEditorGroupUp') end, {})
            vim.keymap.set('n', '<space>s<right>', function() vscode.action('workbench.action.moveActiveEditorGroupRight') end, {})
            -- <space>ff or <C-p> followed by `?` will show all the hotkeys for the vscode quick menu
        end
    })
    vim.api.nvim_create_autocmd({'FileType'}, {
        pattern = {"oil"},
        callback = function()
            vim.keymap.set("n", "-", function() vscode.action('oil-code.openParent') end)
            vim.keymap.set("n", "_", function() vscode.action('oil-code.openCwd') end)
            vim.keymap.set("n", "<CR>", function() vscode.action('oil-code.select') end)
            vim.keymap.set("n", "<C-t>", function() vscode.action('oil-code.selectTab') end)
            vim.keymap.set("n", "<C-l>", function() vscode.action('oil-code.refresh') end)
            vim.keymap.set("n", "`", function() vscode.action('oil-code.cd') end)
        end,
    })
    return
end

-- Lazy Package Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    --stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- set leader before plugin list
vim.g.mapleader = " "
vim.g.maplocalleader = "  "

-- specify plugins
require("lazy").setup({
    spec = { {
        -- themes
        {
            'mcchrish/zenbones.nvim',
            dependencies = {
                { 'rktjmp/lush.nvim' },
            },
            config = function()
                vim.cmd [[colorscheme zenrowan]]
            end
        },

        {
            'stevearc/oil.nvim',
            lazy = false,
            config = function()
                require('oil').setup({
                    -- default_file_explorer = false,
                    -- columns = {"permissions", "size"},
                })
                vim.cmd [[command -nargs=* -complete=file -bar Ex :Oil <args>]]
            end,
        },

        {
            'echasnovski/mini.pick',
            version = false,
            lazy = false,
            config = function()
                local pick = require("mini.pick")
                pick.setup({
                    source = { show = pick.default_show },
                    mappings = { scroll_down = "<C-d>", scroll_up = "<C-u>", delete_left = "<C-k>", choose_marked = "<M-q>", }
                })

                -- vim.keymap.set("n", "<leader>ff", [[<Cmd>Pick files<CR>]])
                vim.keymap.set("n", "<leader>fb", [[<Cmd>Pick buffers<CR>]])
                -- vim.keymap.set("n", "<leader>fg", [[<Cmd>Pick grep live<CR>]])
                -- vim.keymap.set("n", "<leader>fw", [[<Cmd>Pick grep pattern="<cword>"<CR>]])
                -- vim.keymap.set("n", "<leader>fr", [[<Cmd>Pick resume<CR>]])
            end,
        },

        {
            'ibhagwan/fzf-lua',
            opts = {},
            version = false,
            lazy = false,
            config = function()
                require("fzf-lua").setup({
                    "hide",
                    winopts= {
                        -- split = "belowright new",
                        fullscreen = true,
                        border = "none",
                        preview = {
                            border = "border-top",
                            vertical = "down:50%",
                            horizontal = "right:50%",
                            title = "left",
                            layout = "flex",
                            flip_columns = 180,
                        },
                    },
                    keymap = {
                        builtin = {
                            true,
                            ["<C-d>"] = "preview-page-down",
                            ["<C-u>"] = "preview-page-up",
                            ["<S-tab>"] = "toggle-preview",
                        },
                        fzf = {
                            true,
                            ["ctrl-d"] = "preview-page-down",
                            ["ctrl-u"] = "preview-page-up",
                        }
                    },
                })
                vim.keymap.set("n", "<leader>fg", [[<Cmd>FzfLua live_grep<CR>]])
                vim.keymap.set("n", "<leader>fw", [[<Cmd>FzfLua grep_cword<CR>]])
                vim.keymap.set("n", "<leader>fh", [[<Cmd>FzfLua help_tags<CR>]])
                vim.keymap.set("n", "<leader>ft", [[<Cmd>FzfLua builtin<CR>]])
                vim.keymap.set("n", "<leader>fr", [[<Cmd>FzfLua resume<CR>]])
                vim.keymap.set("n", "<leader>ff", function() FzfLua.files({winopts={split = "belowright new", preview = {hidden = true}}}) end)
            end,
        },

        -- luaforth
        {
            'luaforth',
            dir = '~/dotfiles/luaforth',
            config = function()
                require('luaforth').setup({})
                -- Luaforth
                vim.keymap.set('n', '<space>lp', require('luaforth').prompt, {})
                vim.keymap.set('n', '<space>lf', require('luaforth').repl, {})
                vim.keymap.set('n', '<space>lr', require('luaforth').reset, {})
            end,
        },

        -- vim sessions
        {
            'tpope/vim-obsession',
        },

        { 'tpope/vim-dispatch' },

        -- git
        {
            'tpope/vim-fugitive',
            cmd = "Git"
        },
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup {
                    signs = {
                        add = { text = '+' },
                        change = { text = '~' },
                        delete = { text = '-' },
                        topdelete = { text = '-' },
                        changedelete = { text = '#' },
                        untracked = { text = '+' }
                    }
                }
            end
        },

        -- Spellchecker
        {
            'kamykn/spelunker.vim',
            ft = { 'markdown', 'tex' },
            config = function()
                vim.o.spell                = false
                vim.g.enable_spelunker_vim = 0
            end
        },

        -- smart line number toggling
        'jeffkreeftmeijer/vim-numbertoggle',

        -- Tmux Integration
        {
            'christoomey/vim-tmux-navigator',
            config = function()
                vim.g["tmux_navigator_no_mappings"] = 0
                vim.g["tmux_navigator_disable_when_zoomed"] = 1
            end
        },


        -- Treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            lazy = false,
            config = function()
                require('nvim-treesitter.configs').setup({
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false
                    },
                })
                vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
                vim.api.nvim_set_hl(0, "@method.call", { link = "Function" })
            end,

        },

        {
            "mbbill/undotree",
            config = function()
                vim.g["undotree_SetFocusWhenToggle"] = 1;
                vim.keymap.set('n', '<space>fu', "<Cmd>UndotreeToggle<CR>", {})
                vim.o.undofile = true
            end,
        },

        {
            "rej696/vim-send2term",
            config = function()
                vim.g["send2term_cmd_python"] = "uvx -p 3.14 python"
            end,
        },
    } }
})

-- Visual Options
vim.o.conceallevel    = 0 -- Don't hide quotes in markdown
vim.o.cmdheight       = 1
vim.o.pumheight       = 10
vim.o.showmode        = false
vim.o.showtabline     = 1    -- Only show tabline if more than one tab
vim.o.title           = true
vim.o.termguicolors   = true -- Use true colors, required for some plugins
vim.wo.number         = true
vim.wo.relativenumber = true
vim.wo.signcolumn     = 'yes'
vim.wo.cursorline     = true
vim.o.winborder       = 'rounded'

-- folds
vim.o.foldmethod      = 'indent' -- Fold by indentation level
vim.o.foldlevel       = 99       -- Default fold level to 99 (i.e. no folds),
-- z[r,R] reduces and z[m,M] increases(more)
-- R and M to reduce to min/max folds (i.e. zM will allow you to start using folds)
-- zo and zc to open/close individual folds


-- Behavioural Options
vim.o.hlsearch      = false
vim.o.ignorecase    = true -- Ignore case when using lowercase in search
vim.o.smartcase     = true -- But don't ignore it when using upper case
vim.o.smarttab      = true
vim.o.smartindent   = true
vim.o.expandtab     = true -- Convert tabs to spaces. <C-v><tab> to insert a proper tab
vim.o.tabstop       = 8
vim.o.softtabstop   = 4
vim.o.shiftwidth    = 4
vim.o.splitbelow    = true
vim.o.splitright    = true
vim.o.scrolloff     = 5 -- Minimum offset in lines to screen borders
vim.o.sidescrolloff = 8
vim.o.mouse         = 'a'

-- Vim specific Options
vim.o.hidden        = true -- Do not save when switching buffers
vim.o.fileencoding  = "utf-8"
vim.o.spell         = false
vim.o.spelllang     = "en_gb"
vim.o.completeopt   = "fuzzy,menuone,noinsert,noselect"
vim.o.wildmode      = "full"        -- Display auto-complete in Command Mode
vim.o.wildoptions   = "pum,tagfile" -- Display vertical popup menu
vim.o.updatetime    = 300           -- Delay until write to Swap and HoldCommand event

vim.o.formatoptions = "jco/ql"

-- Cindent rules
vim.cmd [[set cino=(s,m1,l1]]

-- vhdl indent rules
vim.g.vhdl_indent_genportmap = 0;

-- exrc
vim.cmd [[set exrc]]

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

-- Trim whitespace
vim.keymap.set({ "n", "v" }, "<leader>tr", ":%s/\\s\\+$//e<CR>", map_opts)
vim.keymap.set("n", "<leader>te", ":AutoTrimWhitespaceEnable<CR>", map_opts)
vim.keymap.set("n", "<leader>td", ":AutoTrimWhitespaceDisable<CR>", map_opts)

-- Swap folder
vim.cmd('command! ListSwap split | enew | r !ls -l ~/.local/share/nvim/swap')
vim.cmd('command! CleanSwap !rm -rf ~/.local/share/nvim/swap/')


-- Keymaps
local map_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ot", ":!fd -e c -e h | ctags -L - <CR>", map_opts)

-- Centre page after pgdn/up
vim.keymap.set("n", "<C-d>", "<C-d>zz", map_opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", map_opts)

-- Centre page after search
vim.keymap.set("n", "n", "nzz", map_opts)
vim.keymap.set("n", "N", "Nzz", map_opts)
vim.keymap.set("n", "*", "*zz", map_opts)

-- Remap Splits
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", map_opts)
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", map_opts)
vim.keymap.set("n", "<leader>sp", ":split<CR>", map_opts)
vim.keymap.set("n", "<A-Left>", ":<C-U>TmuxNavigateLeft<CR>", map_opts)
vim.keymap.set("n", "<A-Down>", ":<C-U>TmuxNavigateDown<CR>", map_opts)
vim.keymap.set("n", "<A-Up>", ":<C-U>TmuxNavigateUp<CR>", map_opts)
vim.keymap.set("n", "<A-Right>", ":<C-U>TmuxNavigateRight<CR>", map_opts)
vim.keymap.set("t", "<A-Left>", "<C-\\><C-n>:<C-U>TmuxNavigateLeft<CR>", map_opts)
vim.keymap.set("t", "<A-Down>", "<C-\\><C-n>:<C-U>TmuxNavigateDown<CR>", map_opts)
vim.keymap.set("t", "<A-Up>", "<C-\\><C-n>:<C-U>TmuxNavigateUp<CR>", map_opts)
vim.keymap.set("t", "<A-Right>", "<C-\\><C-n>:<C-U>TmuxNavigateRight<CR>", map_opts)
vim.keymap.set("n", "<A-h>", ":<C-U>TmuxNavigateLeft<CR>", map_opts)
vim.keymap.set("n", "<A-j>", ":<C-U>TmuxNavigateDown<CR>", map_opts)
vim.keymap.set("n", "<A-k>", ":<C-U>TmuxNavigateUp<CR>", map_opts)
vim.keymap.set("n", "<A-l>", ":<C-U>TmuxNavigateRight<CR>", map_opts)
vim.keymap.set("n", "<A-p>", ":<C-U>TmuxNavigatePrevious<CR>", map_opts)

-- List Buffer then select
vim.keymap.set("n", "<leader>b", ":ls<CR>:b<Space>", map_opts)

-- Delete Current Buffer
vim.keymap.set("n", "<leader>x", ":bd<CR>", map_opts)
vim.keymap.set("n", "[b", ":bnext<CR>", map_opts)
vim.keymap.set("n", "]b", ":bprevious<CR>", map_opts)

-- Buffer Navigation
vim.keymap.set("n", "<A-Home>", ":tabp<CR>", map_opts)
vim.keymap.set("n", "<A-End>", ":tabn<CR>", map_opts)

-- tag navigation
vim.keymap.set("n", "<leader>ts", ":ts<CR>", map_opts)

-- Terminal Remapping
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", map_opts)

-- Quickfix list
vim.keymap.set("n", "<leader>cl", ":cwindow<CR>", map_opts)
vim.keymap.set("n", "<leader>co", ":copen<CR>", map_opts)
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", map_opts)

-- Location list
vim.keymap.set("n", "<leader>ll", ":lwindow<CR>", map_opts)
vim.keymap.set("n", "<leader>lo", ":lopen<CR>", map_opts)
vim.keymap.set("n", "<leader>lc", ":lclose<CR>", map_opts)

-- Show line diagnostics
-- vim.keymap.set("n", "<leader>gd", vim.diagnostic.open_float, map_opts)

-- Fuzzy find files
vim.keymap.set("n", "<leader>fi", ":find **/", map_opts)

-- Git
vim.keymap.set("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk_inline<CR>", map_opts)
vim.keymap.set("n", "]g", "<Cmd>Gitsigns next_hunk<CR>", map_opts)
vim.keymap.set("n", "[g", "<Cmd>Gitsigns prev_hunk<CR>", map_opts)
vim.keymap.set("n", "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>", map_opts)
vim.keymap.set("n", "<leader>gl", "<Cmd>Gitsigns blame_line<CR>", map_opts)
vim.keymap.set("n", "<leader>ga", "<Cmd>Gitsigns stage_hunk<CR>", map_opts)
vim.keymap.set("n", "<leader>gu", "<Cmd>Gitsigns undo_stage_hunk<CR>", map_opts)
vim.keymap.set("n", "<leader>gb", "<Cmd>Git blame<CR>", map_opts)

vim.keymap.set("n", "Zl", "<Cmd>FzfLua spell_suggest<CR>")
vim.keymap.set("n", "z=", "<Cmd>FzfLua spell_suggest<CR>")
vim.keymap.set("n", "Ze", "<Cmd>setlocal spell<CR>", map_opts)
vim.keymap.set("n", "Zd", "<Cmd>setlocal nospell<CR>", map_opts)

-- Close window but not vim
vim.keymap.set("n", "<leader>q", ":close<CR>", map_opts)

-- Don't lose contents of yank register on visual select and paste
vim.keymap.set("x", "<leader>p", "\"_dP", map_opts)
vim.keymap.set("n", "<leader>p", "\"+p", map_opts)
vim.keymap.set("n", "<leader>P", "\"+P", map_opts)

-- Yank to system clipboard, delete to _ register
vim.keymap.set("n", "<leader>y", "\"+y", map_opts)
vim.keymap.set("v", "<leader>y", "\"+y", map_opts)
vim.keymap.set("n", "<leader>Y", "\"+Y", map_opts)

vim.keymap.set("n", "<leader>d", "\"_d", map_opts)
vim.keymap.set("v", "<leader>d", "\"_d", map_opts)
vim.keymap.set("n", "<leader>D", "\"_D", map_opts)

-- Lsp
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufopts = { buffer = ev.buf }
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
        vim.keymap.set({ 'n', 'v', 'x' }, '<leader>F', vim.lsp.buf.format, bufopts)
        vim.keymap.set({ 'n' }, 'grd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set({ 'n' }, 'gd', vim.lsp.buf.definition, bufopts)
        vim.cmd[[set tagfunc=]]
    end,
})

-- tab complete for omnicomplete
vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then return "<C-n>" else return "<Tab>" end
end, { expr = true })


vim.lsp.set_log_level("WARN")

-- Disable inline error messages
vim.diagnostic.config {
    virtual_text = false,
    underline = false, -- Keep error underline
    signs = true,      -- Keep gutter signs
}

vim.lsp.enable({
    'clangd',
    'luals',
    'ruff',
    'basedpyright',
})
if vim.fn.executable('vhdl_ls') == 1 then
    vim.lsp.enable({ 'vhdl_ls' })
end

if vim.fn.executable('robotframework_ls') == 1 then
    vim.lsp.enable({ 'robotframework_ls' })
end

if vim.fn.executable('lemminx') == 1 then
    vim.lsp.enable({ 'xml' })
end

-- Stop LSP from overriding ctags
-- vim.cmd [[set tagfunc=]]

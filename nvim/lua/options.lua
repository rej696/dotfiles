-- Visual
vim.o.conceallevel       = 0                             -- Don't hide quotes in markdown
vim.o.cmdheight          = 1
vim.o.pumheight          = 10
vim.o.showmode           = false
vim.o.showtabline        = 1                             -- Only show tabline if more than one tab
vim.o.title              = true
vim.o.termguicolors      = true                          -- Use true colors, required for some plugins
vim.wo.number            = true
vim.wo.relativenumber    = true
vim.wo.signcolumn        = 'yes'
vim.wo.cursorline        = true
vim.o.foldmethod         = 'indent'                      -- Fold by indentation level
vim.o.foldlevel          = 99                            -- Default fold level to 99 (i.e. no folds), z[r,R] reduces and z[m,M] increases(more)
                                                         -- zo and zc to close individual folds

-- Behaviour
vim.o.hlsearch           = false
vim.o.ignorecase         = true                          -- Ignore case when using lowercase in search
vim.o.smartcase          = true                          -- But don't ignore it when using upper case
vim.o.smarttab           = true
vim.o.smartindent        = true
vim.o.expandtab          = true                          -- Convert tabs to spaces.
vim.o.tabstop            = 8
vim.o.softtabstop        = 4
vim.o.shiftwidth         = 4
vim.o.splitbelow         = true
vim.o.splitright         = true
vim.o.scrolloff          = 5                            -- Minimum offset in lines to screen borders
vim.o.sidescrolloff      = 8
vim.o.mouse              = 'a'

-- Vim specific
vim.o.hidden             = true                          -- Do not save when switching buffers
vim.o.fileencoding       = "utf-8"
vim.o.spell              = false
vim.o.spelllang          = "en_us"
vim.o.completeopt        = "menuone,noinsert,noselect"
vim.o.wildmode           = "longest,full"                -- Display auto-complete in Command Mode
vim.o.updatetime         = 300                           -- Delay until write to Swap and HoldCommand event

-- Fuzzy search
vim.opt.path:append('**')
vim.opt.wildignore:append('__pycache__/*')
vim.o.wildignorecase = true

-- Cindent rules
vim.api.nvim_exec("set cino=(s,m1", true)

-- Disable default plugins
-- vim.g.loaded_netrwPlugin = true

-- Neovide configuration
-- vim.api.nvim_exec ([[
-- if exists("g:neovide")
--     let g:neovide_cursor_animation_length=0
--     set guifont=Hack=h10
-- endif
-- ]],
-- false)

-- Providers
-- vim.g.python3_host_prog  = '/home/milton/software/miniconda/envs/pynvim/bin/python'

-- Disable inline error messages
vim.diagnostic.config {
  virtual_text = false,
  underline = false,            -- Keep error underline
  signs = true,                -- Keep gutter signs
}

-- vim.g["conjure#client#racket#stdio#command"] = "xvfb-racket"
vim.g["conjure#extract#tree_sitter#enabled"] = true
vim.g["conjure#mapping#doc_word"] = {"<space>K"}

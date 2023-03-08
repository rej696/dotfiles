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
if vim.g.neovide then
    vim.o.guifont = "Hack:h10"
    -- vim.g.neovide_padding_top = 0
    -- vim.g.neovide_padding_bottom = 0
    -- vim.g.neovide_padding_right = 0
    -- vim.g.neovide_padding_left = 0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_trail_size = 0
    -- vim.g.neovide_fullscreen = true
    vim.g.neovide_scale_factor = 1.0
end

-- Providers
-- vim.g.python3_host_prog  = '/home/milton/software/miniconda/envs/pynvim/bin/python'

-- Disable inline error messages
vim.diagnostic.config {
  virtual_text = false,
  underline = false,            -- Keep error underline
  signs = true,                -- Keep gutter signs
}


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

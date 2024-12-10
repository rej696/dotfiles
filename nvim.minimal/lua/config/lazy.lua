local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    --stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("lazy").setup(
    {
        spec = {
            -- add LazyVim and import its plugins
            -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- import any extras modules here
            -- eg. { import = "lazyvim.plugins.extras.lang.typescript" },
            -- import/overrid with your plugins
            { import = "plugins" },
        },
        defaults = {
            -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
            -- If you know what you're doing, you can set this to 'true' to have all your custom plugins lazy-loaded by default.
            lazy = false,
            -- It's recommended to leave version=false for now, since a lot of the plugins that support versioning
            -- have outdated releases, which may break your Neovim install.
            -- version = "*", -- always use the latest git commit
        },
        install = {
            missing = true
        },
        checker = { enabled = false }, -- automatically check for plugin updates
    }
)

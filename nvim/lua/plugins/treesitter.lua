-- Treesitter configuration

require('nvim-treesitter.configs').setup({
  highlight = { enable = true, additional_vim_regex_highlighting = false},
  -- We must manually specify which parsers to install
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "json",
    "lua",
    "python",
    "yaml",
    "racket",
    "rust",
    "clojure"
    },
  rainbow = {
    enable = true,
    -- disable = { "c" }
  }
})

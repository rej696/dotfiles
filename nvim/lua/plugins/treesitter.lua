-- Treesitter configuration

require('nvim-treesitter.configs').setup({
  highlight = {
      enable = true,
      additional_vim_regex_highlighting = false

  },
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
    enable = false,
    disable = { "c" }
  },

  playground = {
      enable = true
  },

  textobjects = {
      select = {
          enable = true,
          keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@functions.inner"
          }
      },
      lsp_interop = {
          enable = true,
          border = "single",
          floating_preview_opts = {},
          peek_definition_code = {
              ["<leader>df"] = "@function.outer"
          }
      }
  }
})

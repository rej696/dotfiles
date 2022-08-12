
require('nvim-tree').setup({
    disable_netrw = false,
    hijack_netrw = false,
    update_cwd = false,
    renderer = {
        indent_markers = {
            enable = true,
        },
        highlight_git = false,
        highlight_opened_files = "name",
        add_trailing = true,
        icons = {
            show = {
                folder = false,
                file = false,
                folder_arrow = true,
                git = false
            },
            glyphs = {
                folder = {
                    arrow_closed = ">",
                    arrow_open = "v",
                },
            },
        },
    },
})

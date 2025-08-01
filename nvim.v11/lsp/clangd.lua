return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--enable-config",
        "--offset-encoding=utf-16",
    },
    root_markers = { '.git', 'compile_commands.json', 'compile_flags.txt', 'tags' },
    filetypes = { 'c', 'cpp' },
}

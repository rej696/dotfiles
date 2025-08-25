return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--enable-config",
        -- "--query-driver=\"/opt/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-g*\"",
        -- "--limit-references=0",
        "--offset-encoding=utf-16",
    },
    root_markers = { '.git', 'compile_commands.json', 'compile_flags.txt', 'tags' },
    filetypes = { 'c', 'cpp' },
}

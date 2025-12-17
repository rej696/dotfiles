return {
    cmd = { "neocmakelsp", "stdio" },
    root_markers = { '.git', 'build', '_build', 'cmake' },
    filetypes = { 'cmake' },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    },
    init_options = {
        scan_cmake_in_package = true,
        use_snippets = true,
    }
}

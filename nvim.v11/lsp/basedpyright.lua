return {
    cmd = { 'uvx', '--from', 'basedpyright', 'basedpyright-langserver', '--stdio', },
    filetypes = { 'python'},
    root_markers = {
        'pyproject.toml',
        'requirements.txt',
        '.git',
    },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = True,
                diagnosticMode = 'openFilesOnly',
                ignore = { '*' },
                typeCheckingMode = 'off',
            },
        },
    },
}

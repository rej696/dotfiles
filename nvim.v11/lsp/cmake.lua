return {
    cmd = { 'uvx', '-p', '3.13', '--with', 'pygls<2', 'cmake-language-server' },
    filetypes = { 'cmake' },
    root_markers = { '.git', 'build', '_build', 'cmake' },
    init_options = {
        buildDirectory = 'build',
    },
}

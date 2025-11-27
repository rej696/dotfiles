return {
    cmd = { 'robotframework_ls'},
    filetypes = { 'robot' },
    root_markers = { 'robotidy.toml', 'pyproject.toml', 'robot.yaml', '.git' },
    settings = {
        robot = {
            variables = {
               EXECDIR = "."}}},
}

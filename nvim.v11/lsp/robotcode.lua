return {
    cmd = { 'robotcode', 'language-server', '--stdio' },
    cmd_env = (function()
        local venv = os.getenv("VIRTUAL_ENV")
        if not venv then return nil end
        local site = vim.fn.glob(venv .. "/lib/python*/site-packages")
        return { PYTHONPATH = site }
    end)(),
    filetypes = { 'robot' },
    root_markers = { 'robotidy.toml', 'pyproject.toml', 'robot.yaml', '.git' },
    single_file_support = true,
}

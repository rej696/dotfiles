return {
    cmd = { 'robotframework_ls' },
    filetypes = { 'robot' },
    root_markers = { 'robotidy.toml', 'pyproject.toml', 'robot.yaml', '.git' },
    settings = {
        robot = {
            lint = {
                variables = false,
                -- ignore_variables = {
                --     "TEST_BENCH", "TEST_HARDWARE", "TEST_EXCLUDE",
                --     "SSH_COMMAND", "EXEC_COMMAND", "GRBL_COMMAND",
                --     "EDGECONSOLE_COMMAND", "EGDE_DRIVER", "EDGE_LUN",
                --     "SIGROK", "DIGITAL_INDICATOR_COMMAND", "MOTIONLIB_CONFIG",
                --     "MOTIONLIB_HOST", "MOTIONLIB_PREFIX", "TEST_PLC_HOSTNAME",
                --     "TEST_PLC_LAYOUT", "LUMENS_COMMAND"
                -- },
            },
            variables = {
               EXECDIR = "."
           }
        }
    }
}

return {
    cmd = { 'lemminx' },
    filetypes = { 'xml', 'xsd', 'xsd', 'xslt', 'svg' },
    -- settings = {
    --     xml = {
    --         fileAssociations = {
    --             { pattern = "*.design",systemId = "~/vpc/fesa-xml/design/design-cern.xsd"},
    --             { pattern = "*.deploy", systemId = "~/vpc/fesa-xml/deployment/deployment-cern.xsd" },
    --         },
    --     },
    -- },
    root_markers = {
        '.git',
    },
    single_file_support = true,
}

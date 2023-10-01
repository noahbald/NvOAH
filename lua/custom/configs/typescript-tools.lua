local M = {
    settings = {
        expose_as_code_action = "all",
        tsserver_plugins = {
            "@styled/typescript-styled-plugin",
        },
        -- Prevent file table overflow. FYI this is double the memory that VSCode allows
        tsserver_max_memory = "8192",
    },
}
return M


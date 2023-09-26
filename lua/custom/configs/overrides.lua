local M = {}

M.treesitter = {
    ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "embedded_template",
        -- "svelte",
        "c",
        "markdown",
        "markdown_inline",
    },
    indent = {
        enable = true,
        -- disable = {
        --   "python"
        -- },
    },
    autotag = {
        enable = true,
        enable_rename = true,
        filetypes = {
            'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'tsx', 'jsx', 'rescript', 'eruby',
            -- 'svelte',
            'xml',
            'php',
            'markdown',
            'astro', 'glimmer', 'handlebars', 'hbs',
        },
    }
}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        -- "typescript-language-server", -- replaced with typescript-tools.nvim
        "deno",
        "prettier",
        "ruby-lsp",
        "eslint",
        -- "svelte-language-server",

        -- c/cpp stuff
        "clangd",
        "clang-format",
    },
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true,
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
            },
        },
    },
}

return M

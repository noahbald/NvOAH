local overrides = require("custom.configs.overrides")

local run_lean = false
if string.find(vim.v.progpath, "git") then
    run_lean = true
end

---@type NvPluginSpec[]
local plugins = {

    -- NOTE: Following NvChad/nvcommunity categories

    ---- Completion
    -- TODO: Copilot, if work gives me a license
    -- TODO: llm.nvim, for locally installed LLMs

    ---- Diagnostics

    -- Display list of diagnostics
    {
        "folke/trouble.nvim",
        config = function()
            require("core.utils").load_mappings("trouble")
        end,
        cmd = { "Trouble", "TroubleToggle" },
        event = "BufReadPost",
    },

    ---- Editor

    --- Editor > Essentials

    -- Tabs that work like most editors
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = require 'custom.configs.barbar',
        lazy = run_lean,
        version = "^1.0.0",
        name = "barbar",
    },

    -- Automatically restore sessions for a workspace
    {
        "folke/persistence.nvim",
        config = function()
            local opts = require("custom.configs.persistence")
            require("persistence").setup(opts)
            require("persistence").load()
        end,
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("disabled_persistence"),
                pattern = { "gitcommit" },
                callback = function()
                    require("persistence").stop()
                end,
            })
        end,
        lazy = false,
    },

    --- Editor > Visuals

    -- Make whitespace at end of line visible
    {
        "echasnovski/mini.trailspace",
        event = "VeryLazy",
    },

    -- Highlight other uses of words under the cursor
    {
        "RRethy/vim-illuminate",
        config = function()
            local opts = require("custom.configs.illuminate")
            require("illuminate").configure(opts)
        end,
        dependencies = {
            "nvim-treesitter",
        },
        event = { "CursorHold", "CursorHoldI" },
    },

    -- Highlight TODO comments
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup()
            require("core.utils").load_mappings("todo-comments")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
    },

    -- Show NeoVim notifications in a nicer view
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
        event="VeryLazy",
    },

    --- Editor > Utilities

    -- Cycle between different color formats
    {
        "NTBBloodbath/color-converter.nvim",
        config = function()
            require("core.utils").load_mappings("color-converter")
        end,
        event = "LspAttach",
    },

    -- Global search and replace
    {
        "nvim-pack/nvim-spectre",
        config = function()
            require("spectre").setup()
            require("core.utils").load_mappings("spectre")
        end,
        keys = {
            { "<leader>fr", mode = "n", desc = "Find and replace" },
            { "<leader>fr", mode = "v", desc = "Find and replace" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    ---- Folds

    -- Better automatic folds and more in line with other editors
    {
        "kevinhwang91/nvim-ufo",
        config = function()
            local opts = require("custom.configs.ufo")
            require("ufo").setup(opts)
        end,
        dependencies = {
            "kevinhwang91/promise-async",
            "luukvbaal/statuscol.nvim",
        },
        event = "VeryLazy",
    },

    ---- Git

    -- Display author and git message for current line
    {
        "f-person/git-blame.nvim",
        config = function()
            require("gitblame")     
            require("core.utils").load_mappings("gitblame")
        end,
        event = "VeryLazy",
    },

    -- Display lazygit (a git client) in a window with Vim motions
    {
        "kdheepak/lazygit.nvim",
        config = function()
            require("core.utils").load_mappings("lazygit")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = "LazyGit",
        event = "VeryLazy",
    },

    ---- LSP

    --- LSP > Language

    -- TypeScript LSP made more performant by using native TS Server (like VSCode)
    {
        "pmizio/typescript-tools.nvim",
        config = function()
            local opts = require("custom.configs.typescript-tools")
            require("typescript-tools").setup(opts)
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        build = "npm i -g @styled/typescript-styled-plugin",
        event = "LspAttach",
    },

    --- LSP > Completion

    -- Use CSS selectors as shortcuts for HTML
    {
        "mattn/emmet-vim",
        ft = { "html", "eruby", "javascriptreact" },
    },

    --- LSP > Contextual

    -- Use LSP to improve editor (Breadcrumbs, Code actions window) 
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            local opts = require("custom.configs.lspsaga")
            require("lspsaga").setup(opts)
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        event = "LspAttach",
    },

    -- Add more motions from information provided by LSP (eg Delete-In-Function)
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            local opts = require("custom.configs.nvim-treesitter-textobjects")
            require("nvim-treesitter.configs").setup(opts)
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        event = "LspAttach",
    },

    -- Keep outer scope definitions in view at top of view 
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = require("custom.configs.treesitter-context"),
        event = "BufReadPost",
    },

    --- LSP > Formatting

    -- Add commands for running prettier
    {
        "MunifTanjim/prettier.nvim",
        config = function()
            require("prettier").setup({
                bin = "prettier", -- or `prettierd`
            })
            require("core.utils").load_mappings("prettier")
        end,
        init = function()
            local dir = vim.fn.expand("%:p:h")
            local is_prettier_project = require("custom.configs.prettier").find_prettier_conf(dir)
            if not is_prettier_project then
                return
            end
            vim.schedule(function()
                require("lazy").load { plugins = { "prettier.nvim" } }
            end)
        end,
    },

    ---- Motion

    -- Adds transitions between jumps
    {
        "echasnovski/mini.animate",
        config = function()
            local opts = require "custom.configs.mini"
            require("mini.animate").setup(opts.animate)
        end,
        event = "VeryLazy",
    },


    -- Adds shortcut to jump to any visible word
    {
        "smoka7/hop.nvim",
        config = function()
            require("core.utils").load_mappings("hop")
            require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
        end,
        cmd = { "HopWord", "HopLine", "HopLineStart", "HopWordCurrentLine" },
        event = "BufReadPost",
    },

    ---- NOTE: Not following NvChad/nvcommunity categories

    ---- Debugging

    -- Provide client for Debug Adaptor Protocol
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("core.utils").load_mappings("dap")
        end,
        dependencies = {
            "Weissle/persistent-breakpoints.nvim",
        },
    },

    -- Provide UI to control actively running DAP
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            require("core.utils").load_mappings("dap-ui")
        end,
    },

    -- Store breakpoints on session save and load on session restore
    {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
            require("persistent-breakpoints").setup {
                load_breakpoints_event = { "BufReadPost" },
            }
        end,
    },

    -- Provide access to VSCode's DAP for JavaScript
    {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
            local utils = require("dap-vscode-js.utils")
            require("dap-vscode-js").setup {
                adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
                debugger_path = utils.join_paths(utils.get_runtime_dir(), "lazy/vscode-js-debug"),
            }
            require("custom.configs.nvim-dap-vscode-js")
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            {
                "micrlosoft/vscode-js-debug",
                build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
            }
        },
        ft = { "javascript", "typescript" },
    },

    ---- NOTE: From NvChad's example config

    ---- default custom plugins

    -- Allow configuration of NeoVim's LSP client
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require "custom.configs.null-ls"
                end,
            },
        },
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },

    -- Automatically install and update LSPs
    {
        "williamboman/mason.nvim",
        opts = overrides.mason
    },

    -- Provide plugins access to tree-sitter, a Concrete Syntax Tree generator
    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
    },

    -- Adds a file tree that works like most editors
    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },

    -- Pressing a vertical cursor key in quick succession will return to insert (ie `jj` or `jk`)
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },

    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },

    -- All NvChad plugins are lazy-loaded by default
    -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
    -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
    -- {
    --   "mg979/vim-visual-multi",
    --   lazy = false,
    -- }
}

return plugins

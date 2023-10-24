local overrides = require("custom.configs.overrides")

-- Define contexts where heavy features should be disabled
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

    -- Run ollama models for code completion, setup for codellama:7b-code
    {
        "huggingface/llm.nvim",
        opts = {
            tokens_to_clear = { "<EOT>" },
            fim = {
                enabled = true,
                prefix = "<PRE> ",
                middle = " <MID>",
                suffix = " <SUF>",
            },
            model = "http://localhost:11434/api/generate",
            context_window = 4096,
            tokenizer = {
                repository = "codellama/CodeLlama-7b-hf",
            },
        },
        event = "LspAttach",
        enabled = false,
    },

    -- Run ollama models from neovim
    {
        "David-Kunz/gen.nvim",
        setup = function()
            require("gen").setup()
        end,
        cmd = "Gen",
    },

    ---- Diagnostics

    -- Display list of diagnostics
    {
        "folke/trouble.nvim",
        init = function()
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
            require("which-key").register({ ["<leader>t"] = { name = "+tab"} })
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
        init = function()
            require("persistence").load()
        end,
        opts = require("custom.configs.persistence"),
        lazy = false,
        enabled = vim.fn.argc() == 0,
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
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
        opts = require("custom.configs.illuminate"),
        dependencies = {
            "nvim-treesitter",
        },
        event = { "CursorHold", "CursorHoldI" },
    },

    -- Highlight TODO comments
    {
        "folke/todo-comments.nvim",
        init = function()
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
        init = function()
            vim.notify = require("notify")
        end,
        event="VeryLazy",
        enabled = not run_lean,
    },

    -- Use telescope instead of vim's native select
    {
        "nvim-telescope/telescope-ui-select.nvim",
        init = function()
            require("telescope").load_extension("ui-select")
        end
    },

    --- Editor > Utilities

    -- Color pickers and coversions
    {
        "uga-rosa/ccc.nvim",
        init = function()
            require("core.utils").load_mappings("ccc")
            require("which-key").register({ ["<leader>c"] = { name = "color" } })
        end,
        opts = require("custom.configs.ccc"),
        event = "LspAttach",
    },

    -- Global search and replace
    {
        "nvim-pack/nvim-spectre",
        init = function()
            require("core.utils").load_mappings("spectre")
        end,
        keys = {
            { "<leader>f", mode = "n", desc = "Find and replace" },
            { "<leader>f", mode = "v", desc = "Find and replace" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    -- Show warnings when bad vim habits are used
    {
        "m4xshen/hardtime.nvim",
        config = function()
            require("hardtime").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        enabled = not run_lean,
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
        enabled = not run_lean,
    },

    ---- Git

    -- Display author and git message for current line
    {
        "f-person/git-blame.nvim",
        init = function()
            require("core.utils").load_mappings("gitblame")
        end,
        event = "VeryLazy",
        enabled = not run_lean,
    },

    -- Display lazygit (a git client) in a window with Vim motions
    {
        "kdheepak/lazygit.nvim",
        init = function()
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
        opts = require("custom.configs.typescript-tools"),
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        build = "npm i -g @styled/typescript-styled-plugin",
        event = "LspAttach",
    },

    -- Convert strings to template strings when `${}` syntax is used
    {
        "axelvc/template-string.nvim",
        event = "LspAttach",
    },

    --- LSP > Contextual

    -- Use LSP to improve editor (Breadcrumbs, Code actions window) 
    {
        "nvimdev/lspsaga.nvim",
        init = function()
            require("core.utils").load_mappings("lspsaga")
        end,
        opts = require("custom.configs.lspsaga"),
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        event = "LspAttach",
        enabled = not run_lean,
    },

    -- Add more motions from information provided by LSP (eg Delete-In-Function)
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
        opts = require("custom.configs.nvim-treesitter-textobjects"),
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
        enabled = not run_lean,
    },

    --- LSP > Formatting

    -- Add commands for running prettier
    {
        "MunifTanjim/prettier.nvim",
        init = function()
            local dir = vim.fn.expand("%:p:h")
            local is_prettier_project = require("custom.configs.prettier").find_prettier_conf(dir)
            if not is_prettier_project then
                return
            end
            vim.schedule(function()
                require("core.utils").load_mappings("prettier")
                require("lazy").load { plugins = { "prettier.nvim" } }
            end)
        end,
        opts = { bin = "prettier" }, -- or `prettierd`
        event = "LspAttach",
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
        init = function()
            require("core.utils").load_mappings("hop")
        end,
        opts = { keys = "etovxqpdygfblzhckisuran" },
        cmd = { "HopWord", "HopLine", "HopLineStart", "HopWordCurrentLine" },
        event = "BufReadPost",
    },

    ---- NOTE: Not following NvChad/nvcommunity categories

    ---- Debugging

    -- Provide client for Debug Adaptor Protocol
    {
        "mfussenegger/nvim-dap",
        init = function()
            require("which-key").register({ ["<leader>d"] = { name = "+debug" }})
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
        opts = { load_breakpoints_event = { "BufReadPost" } },
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
                -- FIXME: Clone tends to fail on update
                "microsoft/vscode-js-debug",
                build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && npx move-file dist out",
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

    {
        "folke/which-key.nvim",
        init = function()
            require("which-key").register({
                ["<leader>f"] = { name = "+find" },
                ["<leader>g"] = { name = "+git" },
            })
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

local overrides = require("custom.configs.overrides")

local run_lean = false
if string.find(vim.v.progpath, "git") then
    run_lean = true
end

local function load_on_cwd(plugin)
    local arg_count = vim.api.nvim_exec("echo argc()", true)
    if tonumber(arg_count) ~= 0 then
        return
    end
    require("lazy").load { plugins = { plugin } }
end

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options
    -- UI

    {
        "echasnovski/mini.animate",
        config = function()
            local opts = require "custom.configs.mini"
            require("mini.animate").setup(opts.animate)
        end,
        event = "VeryLazy",
    },

    {
        "echasnovski/mini.trailspace",
        event = "VeryLazy",
    },

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

    {
        "folke/trouble.nvim",
        config = function()
            require("core.utils").load_mappings("trouble")
        end,
        cmd = { "Trouble", "TroubleToggle" },
        event = "BufReadPost",
    },

    -- Editor

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

    {
        "mattn/emmet-vim",
        ft = { "html", "eruby", "javascript" },
    },

    {
        "NTBBloodbath/color-converter.nvim",
        config = function()
            require("core.utils").load_mappings("color-converter")
        end,
        event = "LspAttach",
    },

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

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
    },

    {
        "smoka7/hop.nvim",
        config = function()
            require("core.utils").load_mappings("hop")
            require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
        end,
        cmd = { "HopWord", "HopLine", "HopLineStart", "HopWordCurrentLine" },
        event = "BufReadPost",
    },

    {
        "folke/persistence.nvim",
        config = function()
            local opts = require("custom.configs.persistence")
            require("persistence").setup(opts)
            require("persistence").load()
        end,
        lazy = false,
    },

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

    -- Debugging

    {
        "mfussenegger/nvim-dap",
        config = function()
            require("core.utils").load_mappings("dap")
        end,
        dependencies = {
            "Weissle/persistent-breakpoints.nvim",
        },
    },

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

    {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
            require("persistent-breakpoints").setup {
                load_breakpoints_event = { "BufReadPost" },
            }
        end,
    },

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
                "microsoft/vscode-js-debug",
                build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
            }
        },
        ft = "javascript",
    },

    -- Tools

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

    -- Git

    {
        "f-person/git-blame.nvim",
        config = function()
            require("gitblame")
            require("core.utils").load_mappings("gitblame")
        end,
        event = "VeryLazy",
    },

    {
        "rbong/vim-flog",
        config = function()
            require("core.utils").load_mappings("flog")
        end,
        dependencies = {
            "tpope/vim-fugitive",
        },
        event = "VeryLazy",
    },

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

    -- default custom plugins

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

    -- override plugin configs
    {
        "williamboman/mason.nvim",
        opts = overrides.mason
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },

    -- Install a plugin
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

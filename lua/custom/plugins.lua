local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options
    -- my plugins
    {
        "rmagatti/auto-session",
        lazy = false,
        config = function()
            require("auto-session").setup {
                log_level = "info",
            }
            require "custom.configs.auto-session"
        end
    },

    {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
            require("persistent-breakpoints").setup {
                load_breakpoints_event = { "BufReadPost" },
            }
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        keys = {
            { "BB", mode = "n", desc = "Toggle breakpoint" },
            { "BC", mode = "n", desc = "Set conditional breakpoint" },
            { "BT", mode = "n", desc = "Remove all breakpoints" },
        }
    },

    {
        "rbong/vim-flog",
        dependencies = {
            "tpope/vim-fugitive",
        },
        ft = { "gitcommit", "diff" },
        init = function()
            -- load flog only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("FlogLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "FlogLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = { "vim-flog" } }
                        end)
                    end
                end,
            })
        end,
    },

    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()

            local timing = require "custom.configs.neoscroll"
            require("neoscroll.config").set_mappings(timing)
        end,
        lazy = false,
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
        "gorbit99/codewindow.nvim",
        config = function()
            local codewindow = require("codewindow")
            codewindow.setup({
                auto_enable = true, -- always show on startup
            })
            codewindow.apply_default_keybinds()
        end,
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                callback = function()
                    vim.schedule(function()
                        require("lazy").load { plugins = { "codewindow.nvim" } }
                    end)
                end,
            })
        end,
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

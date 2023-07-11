---@type MappingsTable
local M = {}

M.general = {
    n = {
        [";"] = { ":", "enter command mode", opts = { nowait = true } },
        ["<A-j>"] = { ":m .+1 <CR> =="},
        ["<A-k>"] = { ":m .-2 <CR> =="},
    },
    i = {
        ["<A-j>"] = { "<Esc>:m .+1 <CR> ==gi"},
        ["<A-k>"] = { "<Esc>:m .-2 <CR> ==gi"},
    }
}

M.telescope = {
    n = {
        ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    }
}

M.prettier = {
    plugin = true,

    n = {
        ["<leader>pb"] = { "<cmd> Prettier <CR>", "Run Prettier on buffer" },
    }
}

M.persistent_breakpoints = {
    plugin = true,

    n = {
        ["BB"] = { "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", "Toggle breakpoint"},
        ["BC"] = { "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>", "Set conditional breakpoint" },
        ["BR"] = { "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>", "Remove all breakpoints" },
    }
}

M.flog = {
    plugin = true,

    n = {
        ["<leader>gg"] = { "<cmd> Flog <cr>", "Git Graph" },
    },
}

-- more keybinds!

return M

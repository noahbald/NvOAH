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

-- UI

M.barbar = {
    n = {
        ["<S-Tab>"] = { "<cmd> BufferPrevious <CR>", "Previous Tab" },
        ["<Tab>"] = { "<cmd> BufferNext <CR>", "Next Tab" },
        ["<leader>tl"] = { "<cmd> BufferMovePrevious <CR>", "Move Tab Left" },
        ["<leader>tr"] = { "<cmd> BufferMoveNext <CR>", "Move Tab Right" },
        ["<leader>tp"] = { "<cmd> BufferPin <CR>", "Pin Tab" },
        ["<leader>x"] = { "<cmd> BufferClose <CR>", "Close Tab" },
        ["<leader>tx"] = { "<cmd> BufferCloseAllButPinned <CR>", "Close all Tabs" },
        ["<leader>ts"] = { "<cmd> BufferPick <CR>", "Select tab" },
    }
}

M["todo-comments"] = {
    plugin = true,

    n = {
        ["<leader>ft"] = { "<cmd> TodoTelescope <CR>", "Find TODOs" },
    },
}

-- Editor

M.prettier = {
    plugin = true,

    n = {
        ["<leader>pb"] = { "<cmd> Prettier <CR>", "Run Prettier on buffer" },
    }
}

-- Tools

M.spectre = {
    plugin = true,

    n = {
        ["<leader>fr"] = { "<cmd> lua require(\"spectre\").open_visual() <CR>", "Find and replace"},
    },
    v = {
        ["<leader>fr"] = { "<Esc> <cmd> lua require(\"spectre\").open_visual() <CR>", "Find and replace" },
    },
}

-- Debugging

M.dap = {
    plugin = true,

    n = {
        ["BB"] = { "<cmd> lua require('persistent-breakpoints.api').toggle_breakpoint() <CR>", "Toggle breakpoint"},
        ["BC"] = { "<cmd> lua require('persistent-breakpoints.api').set_conditional_breakpoint() <CR>", "Set conditional breakpoint" },
        ["BX"] = { "<cmd> lua require('persistent-breakpoints.api').clear_all_breakpoints() <CR>", "Remove all breakpoints" },
    }
}

M["dap-vscode-js"] = {
    plugin = true,

    n = {
        ["BR"] = function()
        end,
    }
}

-- Git

M.flog = {
    plugin = true,

    n = {
        ["<leader>gg"] = { "<cmd> Flog <cr>", "Git Graph" },
    },
}

M.gitblame = {
    plugin = true,

    n = {
        ["<leader>gs"] = { "<cmd> GitBlameCopySHA <CR>", "Copy line's Git SHA" },
    },
}
-- Overrides

M.telescope = {
    n = {
        ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
        ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
    }
}

return M

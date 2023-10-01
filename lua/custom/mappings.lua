---@type MappingsTable
local M = {}

M.general = {
    n = {
        [";"] = { ":", "enter command mode", opts = { nowait = true } },
        ["<A-j>"] = { ":m .+1 <CR> ==", "move line down" },
        ["<A-k>"] = { ":m .-2 <CR> ==", "move line up" },
    },
    i = {
        ["<A-j>"] = { "<Esc>:m .+1 <CR> ==gi", "move line down" },
        ["<A-k>"] = { "<Esc>:m .-2 <CR> ==gi", "move line up" },
    },
    v = {
        [">"] = { ">gv", "indent" },
    },
}

---- Diagnostics

M.trouble = {
    plugin = true,

    n = {
        ["<leader>tb"] = { "<cmd> TroubleToggle <cr>", "Toggle issues" },
    },
}

---- Editor

-- Editor > Essentials

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

M.persistence = {
    plugin = true,

    n = {
        ["<leader>rs"] = { "<cmd> lua require(\"persistence\").stop() <cr>", "Don't autosave this session" },
    },
}

-- Editor > Visuals

M["todo-comments"] = {
    plugin = true,

    n = {
        ["<leader>ft"] = { "<cmd> TodoTelescope <CR>", "Find TODOs" },
    },
}

-- Editor > Utilities

M.ccc = {
    plugin = true,

    n = {
        ["<leader>cc"] = { "<cmd> CccConvert <cr>", "Convert color" },
        ["<leader>cp"] = { "<cmd> CccPick <cr>", "Open color picker" },
    },
}

M.spectre = {
    plugin = true,

    n = {
        ["<leader>fr"] = { "<cmd> lua require(\"spectre\").open_visual() <CR>", "Find and replace"},
    },
    v = {
        ["<leader>fr"] = { "<Esc> <cmd> lua require(\"spectre\").open_visual() <CR>", "Find and replace" },
    },
}

---- Folds

---- Git

M.gitblame = {
    plugin = true,

    n = {
        ["<leader>gs"] = { "<cmd> GitBlameCopySHA <CR>", "Copy line's Git SHA" },
    },
}

M.lazygit = {
    plugin = true,

    n = {
        ["<leader>lg"] = { "<cmd> LazyGitCurrentFile <cr>", "Show lazy git" },
    },
}

---- LSP

-- LSP > Language

-- LSP > Completion

-- LSP > Contextual

M.lspsaga = {
    plugin = true,

    n = {
        ["<leader>ca"] = { "<Esc>:Lspsaga code_action<CR>", "Code action" },
        ["<leacer>ra"] = { "<Esc>:Lspsaga rename ++project<CR>", "Rename action" },
    },
}

-- LSP > Formatting

M.prettier = {
    plugin = true,

    n = {
        ["<leader>pb"] = { "<cmd> Prettier <CR>", "Run Prettier on buffer" },
    }
}

---- Motion

M.hop = {
    plugin = true,

    n = {
        ["<leader>w"] = { "<cmd> HopWord <cr>", "Go to word" },
        ["<leader>gw"] = { "<cmd> HopWord <cr>", "Go to word" },
        ["<leader>gl"] = { "<cmd> HopLine <cr>", "Go to line" },
        ["<leader>gL"] = { "<cmd> HopLineStart <cr>", "Go to line start" },
    },
}

---- Debugging

M.dap = {
    plugin = true,

    n = {
        ["<leader>rb"] = { "<cmd> lua require('persistent-breakpoints.api').toggle_breakpoint() <CR>", "DAP: Toggle breakpoint"},
        ["<leader>rc"] = { "<cmd> lua require('persistent-breakpoints.api').set_conditional_breakpoint() <CR>", "DAP: Set conditional breakpoint" },
        ["<leader>rxb"] = { "<cmd> lua require('persistent-breakpoints.api').clear_all_breakpoints() <CR>", "DAP: Remove all breakpoints" },
        ["<leader>rr"] = { "<cmd> lua require('dap').continue() <CR>", "DAP: Start" },
        ["<leader>ri"] = { "<cmd> lua require('dap').step_into() <CR>", "DAP: Step into" },
        ["<leader>ro"] = { "<cmd> lua require('dap').step_over() <CR>", "DAP: Step over" },
        ["<leader>rp"] = { "<cmd> lua require('dap').pause.toggle() <CR>", "DAP: Play/pause" },
        ["<leader>rxq"] = { "<cmd> lua require('dap').close() <CR>", "DAP: Quit debugger" },
        ["<leader>rxd"] = { "<cmd> lua require('dap').disconnect() <CR>", "DAP: Disconnect" },
        ["<leader>rxx"] = { "<cmd> lua require('dap').terminate() <CR>", "DAP: Terminate" },
        ["<leader>rv"] = { "<cmd> lua require('dap.ui.widgets').hover() <CR>", "DAP: Hover variables" },
        ["<leader>rs"] = { "<cmd> lua require('dap.ui.widgets').scopes() <CR>", "DAP: Scopes" },
    }
}

M["dap-ui"] = {
    plugin = true,

    n = {
        ["<leader>rxu"] = { "<cmd> lua require('dapui').toggle() <CR>", "DAP: Toggle UI" },
        ["<leader>re"] = { "<cmd> lua require('dapui').eval(vim.fn.input '[Expression] > ') <CR>", "DAP: Eval input" },
    }
}

---- Overrides

M.telescope = {
    n = {
        ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
        ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
    }
}

return M

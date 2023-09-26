local M = {
    options = {
        "buffers", "curdir", "tabpages", "winsize",
        -- "globals", -- Will cause issues until nvim-tree stops using globals
    },
    pre_save = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
    end,
}
return M


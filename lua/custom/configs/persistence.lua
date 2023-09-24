local M = {
    options = {
        "buffers", "curdir", "tabpages", "winsize",
        "globals",
    },
    pre_save = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
    end,
}
return M


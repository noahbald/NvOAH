---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.telescope = {
  n = {
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
  }
}

-- more keybinds!

return M

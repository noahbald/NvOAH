-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}


---@type Base46HLGroupsList
M.override = {
    Comment = {
        italic = true,
    },
}

---@type HLTable
M.add = {
    IlluminatedWord = { bg = "#252931" },
    IlluminatedCurWord = { bg = "#252931" },
    IlluminatedWordText = { bg = "#252931" },
    IlluminatedWordRead = { bg = "#252931" },
    IlluminatedWordWrite = { bg = "#252931" },

    NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M

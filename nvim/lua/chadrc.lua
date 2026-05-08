-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
M.base46 = {
    theme = "rosepine",
    transparency = true,
    theme_toggle = { "rosepine", "rosepine" },
    hl_override = {
        Comment = {
            fg = "#e8a093",
            italic = true
        },
        ["@comment"] = {
            fg = "#8790b7",
            italic = true
        },
        Variable = {
            italic = true,
        },
        CursorLineNr = {
            fg = "#FFA555"
        },
        LineNr = {
            fg = "#765e93"
        },
        ["@variable"] = {
            italic = true,
        },

    },
}


M.nvdash = {
    load_on_startup = true,

    header = {
        " ███████████  ██████████   █████████    █████████  ███████████",
        "░░███░░░░░███░░███░░░░░█  ███░░░░░███  ███░░░░░███░█░░░███░░░█",
        " ░███    ░███ ░███  █ ░  ░███    ░███ ░███    ░░░ ░   ░███  ░ ",
        " ░██████████  ░██████    ░███████████ ░░█████████     ░███    ",
        " ░███░░░░░███ ░███░░█    ░███░░░░░███  ░░░░░░░░███    ░███    ",
        " ░███    ░███ ░███ ░   █ ░███    ░███  ███    ░███    ░███    ",
        " ███████████  ██████████ █████   █████░░█████████     █████   ",
        "░░░░░░░░░░░  ░░░░░░░░░░ ░░░░░   ░░░░░  ░░░░░░░░░     ░░░░░    ",

        "Welcome Beast  🔥",
        "                                      ",
        "                                      ",
    },
}

M.ui = {
    tabufline = {
        enabled = false,
        order = { "buffers", "tabs" },
    },
    statusline = {
        theme = "vscode_colored",
        separator_style = "arrow",
        order = {
            "mode",
            "file",
            "%=", -- push next modules to center
            "git",
            "diagnostics",
            "lsp",
            "%=", -- push remaining to right
            "cwd",
            "cursor",
        },
    },
    cmp = {
        style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
        format_colors = {
            tailwind = false, 
        },
        -- border_color = "aquarium",
        -- kind_icon = "aquarium",
        -- kind_text = "aquarium",
    },
    telescope = {
        style = "bordered",
        results_color = "rosepine",
        preview_color = "rosepine",
    },
}

return M

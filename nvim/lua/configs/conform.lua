local options = {
    formatters_by_ft = {
        solidity = { "prettier" }, -- Changed to "prettier"
        lua = { "prettier" },
        css = { "prettier" },
        java = { "prettier" }, -- Changed to "prettier"
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        python = { "black" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        objc = { "clang-format" },
        objcpp = { "clang-format" }
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,

    }, -- Ensure the plugin you're using supports this at this level

    -- Uncomment if you need custom arguments
    formatters = {
        -- ======================
        -- Prettier (JS/TS/etc)
        -- ======================
        prettier = {
            args = {
                "--tab-width",
                "4",
                "--use-tabs",
                "false",

            },
        },

        -- ======================
        -- Black (Python)
        -- ======================
        black = {
            args = {
                "--line-length",
                "100",
            },
        },

        -- ======================
        -- Clang-Format (C/C++)
        -- ======================
        ["clang-format"] = {
            args = {
                "--style={IndentWidth: 4, TabWidth: 4, UseTab: Never}",
            },
        },

        -- ======================
        -- Stylua (Lua)
        -- ======================
        -- stylua = {
        --     args = {
        --         "--config-path",
        --         vim.fn.stdpath("config") .. "/stylua.toml",
        --     },
        -- },
    },

    -- Global options

}

return options

require("nvchad.configs.lspconfig").defaults()

local servers = {
    "html",
    "prismals",
    "cssls",        -- was "css_lsp"
    "eslint",
    "ts_ls",
    "sqlls",
    "tailwindcss",  -- was "tailwindcss-language-server"
    "solang",
    "jdtls",
    "gopls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "clangd",
    -- Removed: "typescript_language_server" (duplicate of ts_ls)
     "postgres-language-server"
}

vim.lsp.enable(servers)

-- Build capabilities properly using blink.cmp or nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- If you use blink.cmp:
-- capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
-- If you use nvim-cmp:
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lsp_flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
            desc = "LSP: Format on save",
        })
    end
end

vim.lsp.config("tailwindcss", {
on_attach = function(client, bufnr)
    client.server_capabilities.colorProvider = false,  -- kills bg boxes in JSX/TSX
    on_attach(client, bufnr)
end,
    capabilities = capabilities,
    flags = lsp_flags,
    filetypes = {
        "html", "css", "scss","jsx", "tsx",
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "svelte", "vue",
    },
    settings = {
        tailwindCSS = {
            colorDecorators = false,
            experimental = {
                classRegex = {
                    { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    { "cva\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
            },
            validate = true,
        },
    },
})

-- ESLint
vim.lsp.config("eslint", {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function() vim.cmd("EslintFixAll") end,
            desc = "ESLint: Auto-fix on save",
        })
    end,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
        workingDirectory = { mode = "auto" },
        format = { enable = true },
    },
})

-- All other servers
for _, server in ipairs(servers) do
    if server ~= "eslint" and server ~= "tailwindcss" then
        vim.lsp.config(server, {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = lsp_flags,
        })
    end
end

vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = { multilineTokenSupport = true },
        }
    }
})


vim.diagnostic.config(
    {
        underline = false,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.HINT] = " ",
                [vim.diagnostic.severity.INFO] = " ",
            }
        }
    }
)

vim.diagnostic.config({
    virtual_text = false,
})
-- to configure lsps further read :h vim.lsp.config

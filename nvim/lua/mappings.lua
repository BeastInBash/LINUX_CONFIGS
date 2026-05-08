require "nvchad.mappings"
-- Add local here
local map = vim.keymap.set
local builtin = require('telescope.builtin')
local harpoon = require("harpoon")
local harpoon_ui = require("harpoon.ui")
local M = {}
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- toggle word wrap
map("n", "<leader>z", function()
        vim.wo.wrap = not vim.wo.wrap
    end,
    { desc = "Toggle word wrap" }
)
-- Lsp language server formatting

map('n', '<leader>fm', vim.lsp.buf.format)
-- Telescope Keybindings
-- Find and Replace with confirmation behavior

vim.keymap.set("n", "<leader>fp",
    [[:%s/\<<C-r><C-w>\>//gc<Left><Left>]],
    { desc = "Replace word under cursor with confirmation" }
)
-- Find and replace
vim.keymap.set("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], {
    desc = "Replace word under cursor",
})

map('n', '<leader>db', '<cmd>DBUIToggle<CR>', { desc = "Toggle DB UI" })
-- Find and replace end here
map('n', 'gd', builtin.lsp_definitions, { desc = "Go to Definition" })
map('n', 'gi', builtin.lsp_implementations, { desc = "Implementations" })
map('n', 'gt', builtin.lsp_type_definitions, { desc = "Type Definitions" })
map('n', 'gs', builtin.lsp_document_symbols, { desc = "Document Symbols" })
map('n', 'gr', builtin.lsp_references)
map("n", "<leader>fl", require("telescope.builtin").lsp_references, { noremap = true, silent = true })
-- Noice nvim keymap
map("n", "<leader>ml", function()
    require("noice").cmd("last")
end)

map("n", "<leader>mh", function()
    require("noice").cmd("history")
end)
map("n", "<leader>dn", function()
    require("noice").cmd('dismiss')
end
)

-- Copilot Accept Suggestion
map("i", "<C-p>", "copilot#Accept('<CR>')", { noremap = true, silent = true, expr = true, replace_keycodes = false })

map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

----------------------------------------------------------------------------------------------------------------------------------
-- Toggle spell check
map("n", "<leader>sp", function()
    vim.opt.spell = not vim.opt.spell:get()
    vim.notify("Spell Check : " .. (vim.opt.spell:get() and "enabled" or "disabled"),
        vim.log.levels.INFO,
        { title = "Editor" }
    )
end, { desc = "Toggle spell check" })

----------------------------------------------------------------------------------------------------------------------------------
--Git Blame Toggle
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { noremap = true, silent = true })
map("n", "<leader>td", ":Td<CR>", { noremap = true, silent = true })
-- Toggle Relative Numbers
map("n", "<leader>r", ":set relativenumber!<CR>", { noremap = true, silent = true })

-- Harpoon: Add File
map("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Add file to Harpoon" })

-- -- Harpoon: Toggle Quick Menu
-- map("n", "<C-e>", function()
--   harpoon_ui.toggle_quick_menu(harpoon:list())
-- end, { desc = "Toggle Harpoon quick menu" })
-- Harpoon Navigation
map("n", "<leader>1", function()
    harpoon:list():select(1)
end)
map("n", "<leader>2", function()
    harpoon:list():select(2)
end)
map("n", "<leader>3", function()
    harpoon:list():select(3)
end)
map("n", "<leader>4", function()
    harpoon:list():select(4)
end)

-- Harpoon: Previous & Next
map("n", "<leader>mn", function()
    harpoon:list():prev()
end, { desc = "Previous Harpoon file" })
map("n", "<leader>mf", function()
    harpoon:list():next()
end, { desc = "Next Harpoon file" })

-- Harpoon: Clear List
map("n", "<leader>cc", function()
    harpoon:list():clear()
end, { desc = "Clear Harpoon list" })

-- Markdown Preview
map("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })


-- Toggle checkbox in obsidian.nvim

-- -- Toggle checkbox in obsidian.nvim
-- map("n", "<leader>cc", function()
--   require("obsidian").util.toggle_checkbox()
-- end, { desc = "Toggle checkbox" })
--

-- Toggle Tabline

map("n", "<leader>tt", function()
    vim.opt.showtabline = vim.opt.showtabline:get() == 0 and 2 or 0
end, { desc = "Toggle tabline visibility" })

-- Telescope media_files keymap
vim.keymap.set("n", "<leader>fi", "<cmd>Telescope media_files<CR>", {
    noremap = true,
    silent = true,
    desc = "Find images and media files",
})
-- For pasting something over something  without loosing the copied text
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true, silent = true })
-- To move selected line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- CMP Autocompletion Setup
local cmp = require("cmp")
cmp.setup {
    mapping = {
        -- Use Tab to navigate through and select completion items
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),

        -- Use Shift+Tab to go backwards in completion menu
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),

        -- Accept currently selected item using Enter
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
    },
}

-- Function to adjust font size in Kitty
local function adjust_font_size(amount)
    local kitty_cmd = string.format("<Cmd>silent !kitty @ set-font-size %d<CR>", amount)
    -- vim.system(kitty_cmd, false)
end

-- Keybinds for increasing and decreasing font size
map("n", "<C-+>", function() adjust_font_size(0.2) end, { noremap = true, silent = true })
map("n", "<C-->", function() adjust_font_size(-0.2) end, { noremap = true, silent = true })
-- Create New file
map("n", "<leader>nf", function()
    local fname = vim.fn.input("New file: ")
    if fname ~= "" then
        vim.cmd("edit " .. fname)
    end
end, { desc = "Create new file" })

-- za -> Toggle fold
-- zc -> Close fold
-- zo -> Open fold
-- zM -> Close all folds
-- zR -> Open all folds
--

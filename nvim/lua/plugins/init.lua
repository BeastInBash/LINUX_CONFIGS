return {

-- {
--     "brenoprata10/nvim-highlight-colors",
--     event = "BufReadPre",
--     opts = {
--         render = "foreground",
--         enable_tailwind = true,
--         -- Add these to exclude LSP-provided background colors
--         exclude_filetypes = {},
--         exclude_buftypes = {},
--     },
-- },
{ 
    "roobert/tailwindcss-colorizer-cmp.nvim", 
    config = function () 
        require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 1
        })
    end
},
    {
        "BeastInBash/todos.nvim",
        event = "VeryLazy", -- lazy-load on first real event
        keys = {
            { "<leader>td", desc = "Todo: Open UI" },
            { "<leader>ta", desc = "Todo: Add" },
            { "<leader>tt", desc = "Todo: Toggle" },
            { "<leader>ts", desc = "Todo: Switch scope" },
        },
        config = function()
            require("todo-nvim").setup({
                -- default scope when opening: "project" | "global"
                default_scope = "project",

                -- storage paths (optional overrides)
                storage = {
                    global_path      = vim.fn.stdpath("data") .. "/todo/global.json",
                    project_filename = ".nvim/todo.json",
                },

                -- floating window proportions
                ui = {
                    width       = 0.8, -- fraction of editor width
                    height      = 0.8, -- fraction of editor height
                    border      = "rounded",
                    split_ratio = 0.4, -- left panel fraction
                },

                -- global keymaps (outside the window)
                keymaps = {
                    open   = "<leader>td",
                    add    = "<leader>ta",
                    toggle = "<leader>tt",
                    scope  = "<leader>ts",
                },

                -- in-panel keymaps
                panel_keymaps = {
                    add       = "a",
                    delete    = "d",
                    edit      = "e",
                    toggle    = "<CR>",
                    close     = "q",
                    scope     = "s",
                    next_prio = "p",
                    move_down = "J",
                    move_up   = "K",
                    help      = "?",
                },
                color = {
                    base = "#171717"
                },
            })
        end,
    },
    {
        "BeastInBash/pg-docker.nvim",
        cmd = { "PgCreate", "PgQuickStart", "PgStop", "PgRemove", "PgLogs", "PgList", "PgLog" },
        keys = {
            { "<leader>pgn", "<cmd>PgCreate<cr>",     desc = "pg-docker: new container" },
            { "<leader>pgq", "<cmd>PgQuickStart<cr>", desc = "pg-docker: quick start" },
            { "<leader>pgs", "<cmd>PgStop<cr>",       desc = "pg-docker: stop" },
            { "<leader>pgr", "<cmd>PgRemove<cr>",     desc = "pg-docker: remove" },
            { "<leader>pgl", "<cmd>PgLogs<cr>",       desc = "pg-docker: logs" },
            { "<leader>pgL", "<cmd>PgList<cr>",       desc = "pg-docker: list" },
        },
        opts = {},
    },
    {
        "tpope/vim-dadbod",
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },

        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },

        config = function()
            -- Treesitter context support (important for TSX/JSX)
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })

            require("Comment").setup({
                padding = true,
                sticky = true,
                ignore = nil,

                toggler = {
                    line = "gcc",  -- line comment
                    block = "gbc", -- block comment
                },

                opleader = {
                    line = "gc",  -- visual line comment
                    block = "gb", -- visual block comment
                },

                extra = {
                    above = "gcO",
                    below = "gco",
                    eol = "gcA",
                },

                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },
    
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        config = function()
            require("markview").setup({
                render_delay = 150,
            })
        end,

        -- Completion for `blink.cmp`
        -- dependencies = { "saghen/blink.cmp" },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        ft = { "markdown" },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },

    {
        'wakatime/vim-wakatime',
        lazy = false
    },

    {
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").setup {
                extensions = {
                    media_files = {
                        filetypes = { "png", "jpg", "jpeg", "webp", "gif" },
                        find_cmd = "" -- or "fd"
                    }
                }
            }
            require("telescope").load_extension("media_files")
        end,
    },
{
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },

    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        telescope.setup({
            extensions = {
                fzf = {}
            }
        })

        telescope.load_extension('fzf')

        -- Search Neovim config files
        vim.keymap.set("n", "<space>tn", function()
            builtin.find_files({
                cwd = vim.fn.stdpath("config")
            })
        end, { desc = "Search Neovim config" })

        -- Search git tracked files
        vim.keymap.set("n", "<C-p>", function()
            builtin.git_files()
        end, { desc = "Search Git files" })
    end
},

    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup {
                signs = true,
                keywords = {
                    FIX    = { icon = "", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
                    TODO   = { icon = "", color = "info" },
                    HACK   = { icon = "", color = "warning" },
                    WARN   = { icon = "", color = "warning", alt = { "WARNING" } },
                    PERF   = { icon = "", color = "hint", alt = { "OPTIM", "PERFORMANCE" } },
                    NOTE   = { icon = "", color = "info", alt = { "INFO" } },
                    TEST   = { icon = "⏲", color = "test", alt = { "TESTING", "FAILED" } },
                    PASSED = { icon = "✔ ", color = "success", alt = { "PASSED" } },
                },
                colors = {
                    error   = { "DiagnosticError", "ErrorMsg", "#DD0303" },  -- rose-pine "love"
                    warning = { "DiagnosticWarn", "WarningMsg", "#f6c177" }, -- rose-pine "gold"
                    info    = { "DiagnosticInfo", "#31748f" },               -- rose-pine "pine"
                    hint    = { "DiagnosticHint", "#c4a7e7" },               -- rose-pine "iris"
                    test    = { "Identifier", "#ebbcba" },                   -- rose-pine "rose"
                    success = { "String", "#9ccfd8" },                       -- rose-pine "foam" (green/teal)
                },
            }
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            messages = {
                enabled = true, -- disable Noice messages
            },
            notify = {
                enabled = true, -- disable Noice notifications
            },
            popupmenu = {
                enabled = false, -- disable popupmenu UI
            },
            cmdline = {
                enabled = true, -- keep cmdline enabled
            },
            lsp = {
                progress = {
                    enabled = true, -- disable LSP progress spinner
                },
                hover = {
                    enabled = false, -- disable hover UI
                },
                signature = {
                    enabled = false, -- disable signature help UI
                },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },


    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require "configs.conform",
    },
    {
        "rust-lang/rust.vim"
    },
    {
        "simrat39/rust-tools.nvim"
    },

    { "rose-pine/neovim",         name = "rose-pine" },
    { "ramojus/mellifluous.nvim", name = "mellifluous" },
    {
        "vague2k/vague.nvim",
        name = "vague",
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
        end,
    },

    {
        "prisma/vim-prisma",
        ft = "prisma",
    },
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- Only use setup() if you want a custom install directory
        -- You DON'T need it for highlighting!
        require("nvim-treesitter").install({
            "lua", "vim", "vimdoc", "javascript", "html",
            "bash", "css", "typescript", "tsx", "json",
            "java", "go", "markdown", "markdown_inline", "prisma", "python"
        })

        -- THIS is what enables highlighting now (Neovim built-in)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "javascript", "typescript", "tsx", "lua", "html",
                "css", "json", "python", "go", "java", "bash",
                "markdown", "prisma"
            },
            callback = function()
                vim.treesitter.start()         -- syntax highlighting
            end,
        })
    end,
},

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        event = "InsertEnter",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    -- NOTE: Github copilot is disabled for now
    -- {
    --   "github/copilot.vim",
    --   lazy = false,
    --   config = function()
    --     vim.g.copilot_no_tab_map = true
    --     vim.g.copilot_assume_mapped = true
    --     vim.g.copilot_tab_fallback = ""
    --   end,
    -- },
{
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local colorizer = require("tailwindcss-colorizer-cmp")

        -- 🔑 initialize the colorizer with your preferred symbol
        colorizer.setup({ color_square_width = 2 })

        cmp.setup {
            formatting = {
                format = colorizer.formatter,  -- 🔑 this was missing
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
            },
        }
    end,
},
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require "null-ls"
            null_ls.setup {
                sources = {
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.diagnostics.eslint,
                },
            }
        end,
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require "harpoon"
            -- REQUIRED
            harpoon:setup {
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true,
                    key = function()
                        return vim.loop.cwd()
                    end,
                },
            }
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        end,
    },
    -- Code Snippte plugin
    { "rafamadriz/friendly-snippets" },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",                -- Use latest v2 release
        build = "make install_jsregexp", -- Optional: improves regex-based snippets
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local luasnip = require("luasnip")

            -- Load snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local screen_width = vim.o.columns
            local window_width = 50
            local window_height = vim.o.lines - 2

            require("nvim-tree").setup {
                actions = {
                    remove_file = {
                        close_window = true,
                    },
                },
                filters = {
                    dotfiles = false,
                    custom = {},
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                renderer = {
                    highlight_git = true,
                    highlight_opened_files = "all",
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        show = {
                            git = true,
                        },
                    },
                },
                view = {
                    float = {
                        enable = true,
                        open_win_config = {
                            relative = "editor",
                            border = "none",
                            width = window_width,
                            height = window_height,
                            row = 1,                  -- Center vertically
                            col = (screen_width - 0), -- Center horizontally
                        },
                    },
                },
            }
        end
    },
    -- Luasnip-Markdown-snippets.nvim
    {
        "LukasKorotaj/Luasnip-Markdown-snippets.nvim",
        dependencies = { "L3MON4D3/LuaSnip" },
        config = true,
    },
    -- Clok nvim hedes the env
    {
        'laytan/cloak.nvim',
        event = { 'BufReadPre', 'BufNewFile' }, -- load when opening files
        config = function()
            local cloak = require('cloak')

            cloak.setup({
                enabled = true,
                cloak_character = '*',
                highlight_group = 'Comment',
                cloak_telescope = true,

                patterns = {
                    {
                        file_pattern = { '.env*' },
                        cloak_pattern = '=.+',
                    },
                },
            })

            -- Optional: automatically enable cloaking only for `.env` files
            vim.api.nvim_create_autocmd('BufReadPost', {
                pattern = '.env*',
                callback = function()
                    cloak.enable()
                end,
            })

            -- Keymap to toggle cloak manually
            vim.keymap.set('n', '<leader>tc', function()
                cloak.toggle()
                vim.notify('Cloak toggled', vim.log.levels.INFO, { title = 'cloak.nvim' })
            end, { desc = 'Toggle Cloak (cloak.nvim)' })
        end,
    },
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", 
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "amongus",
                options = {
                    multilines = {
                        enabled = true,
                    },

                    softwrap = 30,
                    overflow = {
                        mode = "wrap",
                        padding = 2,
                    },
                },
            })
            vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
        end,
    },


    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        'vyfor/cord.nvim',
        build = ':Cord update',
        event = "VeryLazy",
        opts = {
            timestamp = {
                enabled = true,
                reset_on_idle = true,
                reset_on_change = false,
            },
            idle = {
                enabled = true,
                timeout = 300000, -- 5 minutes
                text = 'Gone dark... 🌑',
                tooltip = 'Probably debugging in my head',
            },
            text = {
                -- Editing messages — rotates per file via a custom hook
                editing = function(opts)
                    local victims = {
                        '⚔️ Beast Slaying bugs in ' .. opts.filename,
                        '🔥 Beast Burning down ' .. opts.filename,
                        '🧠 Beast Outsmarting ' .. opts.filename,
                        '💀 Beast Murdering ' .. opts.filename,
                        '🩸 Beast Bleeding into ' .. opts.filename,
                        '🌀 Beast unleashing his fangs on ' .. opts.filename,
                        '⚡ Overclocking : ' .. opts.filename,
                        '🎯 Sniping bugs in : ' .. opts.filename,
                        '😵‍💫 Frying Brain.exe : ' .. opts.filename,
                    }
                    return victims[math.random(#victims)]
                end,
                file_browser = function(opts)
                    return '📂 Digging through ' .. opts.tooltip
                end,
                plugin_manager = '📦 Updating the arsenal...',
                lsp_manager = '🔧 Calibrating the weapons',
                docs = '📖 Reading the forbidden scrolls',
                vcs = '🌿 Rewriting history in ' .. '${tooltip}',
                notes = '📝 Plotting something...',
                -- Workspace status
                workspace = 'in ${workspace}',
            },
            buttons = {
                {
                    label = '👾 My GitHub',
                    url = 'https://github.com/thebeast01', -- replace with yours
                },
            },
            variables = true,
        },
    },
}

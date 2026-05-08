require "nvchad.options"

local opt = vim.opt

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- ui
opt.cursorlineopt = "both"
opt.number = false
opt.relativenumber = true
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.swapfile = false
opt.cmdheight = 0

-- wrapping (FINAL SETTINGS)
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.textwidth = 120 -- visual wrap only
opt.formatoptions:append("t")
-- opt.colorcolumn = "100" -- guideline only


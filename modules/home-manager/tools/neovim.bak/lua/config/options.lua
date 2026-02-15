local opt = vim.opt

-- Clipboard
opt.clipboard = "unnamedplus"

-- Appearance
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.colorcolumn = "120"

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Behavior
opt.hidden = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true

-- Backup/swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

-- Which-key timeout
opt.timeout = true
opt.timeoutlen = 300

-- Transparent background
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

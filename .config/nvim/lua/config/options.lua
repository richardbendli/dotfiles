local opt = vim.opt

-- Editor
opt.relativenumber  = true
opt.scrolloff       = 8
opt.sidescrolloff   = 8
opt.wrap            = false
opt.colorcolumn     = "88"
opt.cursorline      = true

-- Indentation
-- Python PEP8 = 4 spaces. LazyVim defaults to 2. Override globally,
-- then autocmds.lua will set 2 for lua/yaml etc.
opt.tabstop         = 4
opt.shiftwidth      = 4
opt.softtabstop     = 4
opt.expandtab       = true

-- Search
opt.ignorecase      = true
opt.smartcase       = true

-- iles & Persistence
opt.undofile        = true
opt.swapfile        = false
opt.backup          = false
opt.updatetime      = 200

-- Clipboard
opt.clipboard       = "unnamedplus"

-- Splits
opt.splitright      = true
opt.splitbelow      = true

-- Appearance
opt.conceallevel    = 2          -- needed for render-markdown.nvim
opt.pumheight       = 10         -- completion menu max height
opt.showmode        = false      -- lualine handles this

-- Shell:
-- Make terminal commands use bash (consistent across distros)
opt.shell           = "/bin/bash"

-- Folding
opt.foldmethod      = "expr"
opt.foldexpr        = "nvim_treesitter#foldexpr()"
opt.foldenable      = false      -- start with all folds OPEN
opt.foldlevel       = 99

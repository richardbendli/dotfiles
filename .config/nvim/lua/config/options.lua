-- lua/config/options.lua
-- LazyVim sets sane defaults. This file EXTENDS/OVERRIDES them.
-- LazyVim defaults ref: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- ── Editor ─────────────────────────────────────────────────────────────────
opt.relativenumber  = true       -- rnu is essential for motion efficiency (LazyVim sets number=true)
opt.scrolloff       = 8          -- LazyVim sets 4, 8 is better
opt.sidescrolloff   = 8
opt.wrap            = false      -- no line wrapping (toggle with <leader>uw)
opt.colorcolumn     = "88"       -- Python black's line length — visual guide
opt.cursorline      = true       -- highlight current line

-- ── Indentation ────────────────────────────────────────────────────────────
-- Python PEP8 = 4 spaces. LazyVim defaults to 2. Override globally,
-- then autocmds.lua will set 2 for lua/yaml etc.
opt.tabstop         = 4
opt.shiftwidth      = 4
opt.softtabstop     = 4
opt.expandtab       = true

-- ── Search ─────────────────────────────────────────────────────────────────
opt.ignorecase      = true
opt.smartcase       = true       -- case-sensitive when you use capitals

-- ── Files & Persistence ────────────────────────────────────────────────────
opt.undofile        = true       -- persist undo history across sessions
opt.swapfile        = false
opt.backup          = false
opt.updatetime      = 200        -- faster CursorHold (document highlight, hover)

-- ── Clipboard ──────────────────────────────────────────────────────────────
-- LazyVim already sets clipboard=unnamedplus on non-SSH sessions.
-- Force it always (useful on Kali/headless with xclip/wl-clipboard):
opt.clipboard       = "unnamedplus"

-- ── Splits ─────────────────────────────────────────────────────────────────
opt.splitright      = true
opt.splitbelow      = true

-- ── Appearance ─────────────────────────────────────────────────────────────
opt.conceallevel    = 2          -- needed for render-markdown.nvim
opt.pumheight       = 10         -- completion menu max height
opt.showmode        = false      -- lualine handles this

-- ── Shell: important for your workflow ─────────────────────────────────────
-- Make terminal commands use bash (consistent across distros)
opt.shell           = "/bin/bash"

-- ── Folding (Neovim 0.10+ treesitter folds) ────────────────────────────────
opt.foldmethod      = "expr"
opt.foldexpr        = "nvim_treesitter#foldexpr()"
opt.foldenable      = false      -- start with all folds OPEN
opt.foldlevel       = 99

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Filetype-specific indentation
vim.api.nvim_create_autocmd("FileType", {
  group   = augroup("indent"),
  pattern = { "lua", "yaml", "json", "toml", "html", "css", "javascript", "typescript" },
  callback = function()
    vim.opt_local.tabstop     = 2
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Terraform: ensure correct filetype detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group   = augroup("terraform_ft"),
  pattern = { "*.tf", "*.tfvars", "*.hcl" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

-- Python
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup("python_settings"),
  pattern  = "python",
  callback = function()
    vim.opt_local.colorcolumn = "88"    -- black's line length as a visual guide
    vim.opt_local.foldmethod  = "indent"
    vim.opt_local.foldlevel   = 99
  end,
})

-- Bash: always treat sh as bash
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup("bash_settings"),
  pattern  = { "sh", "bash" },
  callback = function()
    vim.b.is_bash        = 1
    vim.g.sh_fold_enabled = 1
  end,
})

-- Markdown: writing-friendly settings
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup("markdown_settings"),
  pattern  = "markdown",
  callback = function()
    vim.opt_local.wrap         = true     -- wrap long lines (prose, not code)
    vim.opt_local.spell        = true     -- spell checking on
    vim.opt_local.spelllang    = "en_gb"  -- change to en_us if preferred
    vim.opt_local.conceallevel = 2        -- required by render-markdown.nvim

    -- j/k navigate visual lines when text wraps — stops jumping over paragraphs
    vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
    vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })
  end,
})

-- TOML: project config files
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup("toml_settings"),
  pattern  = "toml",
  callback = function()
    vim.opt_local.tabstop     = 2
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- JSON
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup("json_settings"),
  pattern  = { "json", "jsonc" },
  callback = function()
    vim.opt_local.tabstop     = 2
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.foldmethod  = "syntax"
    vim.opt_local.foldlevel   = 99        -- start fully expanded
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group    = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Auto-create parent directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group    = augroup("auto_mkdir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Return to last cursor position on reopen
vim.api.nvim_create_autocmd("BufReadPost", {
  group    = augroup("last_position"),
  callback = function(event)
    local exclude = { "gitcommit", "gitrebase", "svn", "hgcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then return end
    local mark   = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close utility filetypes with just q
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup("close_with_q"),
  pattern  = {
    "help", "lspinfo", "man", "notify", "qf",
    "spectre_panel", "startuptime", "tsplayground",
    "checkhealth", "query",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>",
      { buffer = event.buf, silent = true })
  end,
})

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group    = augroup("strip_whitespace"),
  pattern  = { "*.py", "*.sh", "*.bash", "*.tf", "*.lua",
               "*.yaml", "*.yml", "*.toml", "*.json" },
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

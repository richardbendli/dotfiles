local map = vim.keymap.set

-- =============================================================================
-- MOTION & EDITING FIXES
-- =============================================================================

-- Keep cursor centred when scrolling/searching — stops disorienting jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centred)", silent = true })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centred)",   silent = true })
map("n", "n",     "nzzzv",   { desc = "Next result (centred)", silent = true })
map("n", "N",     "Nzzzv",   { desc = "Prev result (centred)", silent = true })

-- Y should act like D and C — yank to end of line, not whole line (vim inconsistency)
map("n", "Y", "y$", { desc = "Yank to EOL", silent = true })

-- Join lines without the cursor jumping to the join point
map("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)", silent = true })

-- Search word under cursor but don't jump away immediately
map("n", "*", "*N", { desc = "Search word (no jump)", silent = true })

-- Stay in visual mode after indenting to keep shifting
map("v", "<", "<gv", { desc = "Indent left (stay in visual)",  silent = true })
map("v", ">", ">gv", { desc = "Indent right (stay in visual)", silent = true })

-- Move selected lines up/down and re-indent
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up",   silent = true })

-- =============================================================================
-- REGISTERS & CLIPBOARD
-- =============================================================================

-- Paste over a visual selection WITHOUT losing yank register.
map("x", "<leader>p", '"_dP', { desc = "Paste (preserve register)", silent = true })

-- Delete without polluting the yank register
map({ "n", "v" }, "<leader>D", '"_d', { desc = "Delete to void register", silent = true })

-- Explicit system clipboard yanks
-- integration needs xclip/wl-clipboard and sometimes falls back
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard",      silent = true })
map("n",          "<leader>Y", '"+Y', { desc = "Yank line to system clipboard", silent = true })

-- =============================================================================
-- SEARCH & REPLACE
-- =============================================================================

-- Replace every occurrence of the word under cursor in this file.
map("n", "<leader>sr",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Replace word under cursor (file)" })

-- Same but only within a visual selection
map("v", "<leader>sr",
  ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Replace word under cursor (selection)" })

-- =============================================================================
-- QUICKFIX & LOCATION LIST
-- =============================================================================
-- Essential navigation when using LSP references, grep results, diagnostics.

map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix item",  silent = true })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix item",  silent = true })
map("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next location item",  silent = true })
map("n", "[l", "<cmd>lprev<CR>zz", { desc = "Prev location item",  silent = true })
map("n", "<leader>xo", "<cmd>copen<CR>",  { desc = "Open quickfix list",  silent = true })
map("n", "<leader>xc", "<cmd>cclose<CR>", { desc = "Close quickfix list", silent = true })

-- =============================================================================
-- FILE OPERATIONS
-- =============================================================================

-- Source the current file
map("n", "<leader>so", "<cmd>source %<CR>", { desc = "Source current file", silent = true })

-- Make the current file executable in one keystroke.
-- Workflow: write bash script → <leader>cx → run it.
map("n", "<leader>cx", "<cmd>!chmod +x %<CR>",
  { desc = "chmod +x (make executable)", silent = true })

-- Copy file path to clipboard
map("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy absolute file path" })

map("n", "<leader>cP", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy relative file path" })

-- =============================================================================
-- FILETYPE RUNNER
-- =============================================================================
-- Run the current file without leaving Neovim. Opens a split terminal.
-- Detects filetype automatically

map("n", "<leader>rr", function()
  local ft   = vim.bo.filetype
  local file = vim.fn.expand("%:p")
  local runners = {
    python = "python3 ",
    sh     = "bash ",
    bash   = "bash ",
    lua    = function() vim.cmd("source %") end,
  }
  local runner = runners[ft]
  if type(runner) == "function" then
    runner()
  elseif runner then
    vim.cmd("split | terminal " .. runner .. file)
    vim.cmd("startinsert")
  else
    vim.notify("No runner configured for: " .. ft, vim.log.levels.WARN)
  end
end, { desc = "Run current file" })

-- =============================================================================
-- UI TOGGLES
-- =============================================================================

map("n", "<leader>uw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  vim.notify("Wrap: " .. tostring(vim.opt.wrap:get()))
end, { desc = "Toggle word wrap" })

map("n", "<leader>ur", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative numbers" })

map("n", "<leader>uc", function()
  if vim.opt.colorcolumn:get()[1] then
    vim.opt.colorcolumn = ""
  else
    vim.opt.colorcolumn = "88"
  end
end, { desc = "Toggle colour column (88)" })

-- =============================================================================
-- TERMINAL
-- =============================================================================

-- LazyVim uses snacks terminal for floating term. These add split-based ones:
map("n", "<leader>tv", "<cmd>vsplit | terminal<CR>",
  { desc = "Terminal (vertical split)",   silent = true })
map("n", "<leader>th", "<cmd>split  | terminal<CR>",
  { desc = "Terminal (horizontal split)", silent = true })

-- Escape terminal mode without reaching for Ctrl-\ Ctrl-n
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })


-- =============================================================================
-- HARPOON 2
-- =============================================================================
-- Fast bookmarks for 2-4 files you're actively switching between.
-- Better than bufferline for focused work: bookmark your main script,
-- your notes file, your config — jump between them instantly.
--
--   <leader>ha      → add current file to harpoon list
--   <leader>hh      → open the harpoon quick menu
--   <leader>1-4     → jump directly to harpoon slot 1/2/3/4

map("n", "<leader>ha", function() require("harpoon"):list():add() end,
  { desc = "Harpoon: add file" })
map("n", "<leader>hh", function()
  local h = require("harpoon")
  h.ui:toggle_quick_menu(h:list())
end, { desc = "Harpoon: menu" })

for i = 1, 4 do
  map("n", "<leader>" .. i, function()
    require("harpoon"):list():select(i)
  end, { desc = "Harpoon: file " .. i })
end

-- Commands:
--   -               open parent directory of current file (from any buffer)
--   <leader>o       open current working directory in oil
--   <leader>O       open oil in a floating window
--
-- Inside an oil buffer:
--   <CR>            open file / enter directory
--   -               go up to parent directory
--   _               open current directory in oil (reset to cwd)
--   gs              sort files (toggle)
--   gx              open file with system default app
--   gp              preview file in a split (without opening it)
--   g.              toggle hidden files (dotfiles)
--   g\              toggle trash (if configured)
--   <C-s>           open file in vertical split
--   <C-h>           open file in horizontal split
--   <C-t>           open file in new tab
--   <C-p>           preview in floating window
--   <C-c>           close oil and return to original buffer
--   <C-l>           refresh the directory listing
--
-- File operations (all applied on :w):
--   Rename file     → edit the filename text on that line
--   Delete file     → dd (delete the line)
--   Create file     → type a new line with the name
--   Create dir      → type a new line ending in /
--   Move file       → cut line (dd), open target dir, paste (p)
--   Copy file       → yy the line, open target dir, paste (p)

return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Load immediately so `-` works from any buffer on startup
    lazy = false,
    keys = {
      {
        "-",
        "<cmd>Oil<CR>",
        desc = "Oil: open parent directory",
      },
      {
        "<leader>o",
        "<cmd>Oil<CR>",
        desc = "Oil: open current directory",
      },
      {
        "<leader>O",
        function()
          require("oil").open_float()
        end,
        desc = "Oil: open (floating window)",
      },
    },
    opts = {
      -- Use oil as the default file explorer when you do :e .
      -- Set false if you prefer neo-tree to handle :e .
      default_file_explorer = true,

      -- Columns shown in the buffer
      columns = {
        "icon",         -- file type icon
        "permissions",  -- rwxr-xr-x style
        "size",         -- file size
        "mtime",        -- last modified time
      },

      -- Buffer-local options for oil buffers
      buf_options = {
        buflisted   = false,
        bufhidden   = "hide",
      },

      -- Window options for oil buffers
      win_options = {
        wrap         = false,
        signcolumn   = "no",
        cursorcolumn = false,
        foldcolumn   = "0",
        spell        = false,
        list         = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },

      -- Prompt before deleting files (safety net)
      delete_to_trash = false,         -- true = move to trash instead of deleting
      skip_confirm_for_simple_edits = false,  -- always confirm destructive ops

      -- Restore cursor to original file after closing oil
      restore_win_options = true,

      -- Keymaps inside oil buffers
      -- These are the defaults
      keymaps = {
        ["g?"]    = "actions.show_help",
        ["<CR>"]  = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"]     = "actions.parent",
        ["_"]     = "actions.open_cwd",
        ["`"]     = "actions.cd",
        ["~"]     = "actions.tcd",
        ["gs"]    = "actions.change_sort",
        ["gx"]    = "actions.open_external",
        ["g."]    = "actions.toggle_hidden",
        ["g\\"]   = "actions.toggle_trash",
        ["gp"]    = "actions.preview",
      },

      -- Show hidden files (dotfiles) by default
      -- Toggle with g. inside oil buffer
      view_options = {
        show_hidden = false,          -- toggle with g. inside oil
        -- Highlight git-ignored files differently
        is_hidden_file = function(name, _)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, _)
          -- Always hide these even when show_hidden = true
          return name == ".." or name == ".git"
        end,
        natural_order = true,         -- sort 2 before 10
        sort = {
          { "type", "asc" },          -- directories first
          { "name", "asc" },          -- then alphabetical
        },
      },

      -- Floating window config (used by <leader>O)
      float = {
        padding       = 2,
        max_width     = 0,            -- 0 = auto
        max_height    = 0,
        border        = "rounded",
        win_options   = { winblend = 0 },
      },

      -- Preview window (shown with <C-p> or gp)
      preview = {
        max_width    = 0.9,
        min_width    = { 40, 0.4 },
        width        = nil,
        max_height   = 0.9,
        min_height   = { 5, 0.1 },
        height       = nil,
        border       = "rounded",
        win_options  = { winblend = 0 },
        update_on_cursor_moved = true,
      },
    },
  },
}

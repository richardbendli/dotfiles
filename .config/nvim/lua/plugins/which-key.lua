return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Delay before popup appears (ms)
      -- Lower = popup shows faster
      delay = 300,

      icons = {
        mappings = true,   -- show icons next to mappings
        keys     = {},     -- use default key icons
      },

      -- which-key window appearance
      win = {
        border   = "rounded",
        padding  = { 1, 2 },
        wo = { winblend = 0 },
      },

      layout = {
        width  = { min = 20 },
        spacing = 3,
      },

      -- Show a warning on duplicate keymaps
      notify = true,
    },

    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Group labels
      -- These label the <leader>X prefixes so the popup shows category names
      -- instead of just the raw key. Covers every prefix used across our config.
      wk.add({

        -- Top-level groups
        { "<leader>a", group = "ai (codecompanion)",    icon = " " },
        { "<leader>b", group = "buffer",              icon = "󰓩 " },
        { "<leader>c", group = "code / clipboard",    icon = " " },
        --{ "<leader>d", group = "diagnostics",         icon = " " },
        { "<leader>f", group = "find (telescope)",    icon = " " },
        { "<leader>g", group = "git",                 icon = " " },
        { "<leader>h", group = "harpoon",             icon = "󱡁 " },
        --{ "<leader>l", group = "lsp",                 icon = " " },
        { "<leader>n", group = "notes / annotations", icon = " " },
        { "<leader>r", group = "run / replace",       icon = " " },
        --{ "<leader>s", group = "splits",              icon = " " },
        { "<leader>t", group = "terminal",            icon = " " },
        { "<leader>u", group = "ui toggles",          icon = " " },
        { "<leader>v", group = "virtualenv (python)", icon = " " },
        { "<leader>w", group = "workspace (lsp)",     icon = "󰈙 " },
        { "<leader>o", group = "oil (file explorer)",  icon = " " },
        { "<leader>x", group = "lists / trouble",     icon = " " },

        -- Harpoon slots: show what's in each slot
        -- These override the plain number keys with a meaningful description
        { "<leader>1", desc = "Harpoon: jump to file 1", icon = "󱡁 " },
        { "<leader>2", desc = "Harpoon: jump to file 2", icon = "󱡁 " },
        { "<leader>3", desc = "Harpoon: jump to file 3", icon = "󱡁 " },
        { "<leader>4", desc = "Harpoon: jump to file 4", icon = "󱡁 " },

        -- AI detail
        { "<leader>ac", desc = "AI: Toggle chat",         icon = " " },
        { "<leader>ai", desc = "AI: Inline assist",       icon = " " },
        { "<leader>aa", desc = "AI: Add buffer to chat",  icon = " " },
        { "<leader>aq", desc = "AI: Quick ask",           icon = " " },
        { "<leader>ap", desc = "AI: Prompt actions",      icon = " " },

        -- Buffer group detail
        { "<leader>bp", desc = "Pin buffer",                  icon = " " },
        { "<leader>bP", desc = "Close unpinned buffers",      icon = "󰅖 " },
        { "<leader>bo", desc = "Close other buffers",         icon = "󰅖 " },
        { "<leader>bl", desc = "Close buffers to the right",  icon = " " },
        { "<leader>bL", desc = "Close buffers to the left",   icon = " " },
        { "<leader>bd", desc = "Delete buffer (keep split)",  icon = "󰅖 " },

        -- Git group detail
        { "<leader>gg", desc = "Lazygit",             icon = " " },
        { "<leader>gs", desc = "Git status",          icon = " " },
        { "<leader>gb", desc = "Git blame (line)",    icon = " " },
        { "<leader>gd", desc = "Git diff",            icon = " " },
        { "<leader>gp", desc = "Preview hunk",        icon = " " },
        { "<leader>gr", desc = "Reset hunk",          icon = " " },
        { "<leader>gR", desc = "Reset buffer",        icon = " " },
        { "<leader>gS", desc = "Stage hunk",          icon = " " },
        { "<leader>gu", desc = "Unstage hunk",        icon = " " },
        { "<leader>tb", desc = "Toggle line blame",   icon = " " },

        -- UI toggles detail
        { "<leader>uw", desc = "Toggle word wrap",        icon = " " },
        { "<leader>ur", desc = "Toggle relative numbers", icon = " " },
        { "<leader>uc", desc = "Toggle colour column",    icon = " " },
        { "<leader>uh", desc = "Toggle inlay hints",      icon = "󰔢 " },
        --{ "<leader>ud", desc = "Toggle diagnostics",      icon = " " },

        -- Notes / annotations detail
        { "<leader>nn", desc = "New note (pick type + title)", icon = " " },
        { "<leader>nf", desc = "Find notes (this project)",    icon = " " },
        { "<leader>ng", desc = "Grep notes (this project)",    icon = " " },
        { "<leader>no", desc = "Open notes/ in neo-tree",      icon = " " },
        { "<leader>nt", desc = "All annotations (project)",    icon = " " },
        { "<leader>nT", desc = "TODO + FIX only",              icon = " " },

        -- Terminal detail
        { "<leader>tv", desc = "Terminal (vertical split)",   icon = " " },
        { "<leader>th", desc = "Terminal (horizontal split)", icon = " " },

        -- Run / replace detail
        { "<leader>rr", desc = "Run current file (auto-detected)", icon = " " },
        { "<leader>sr", desc = "Replace word under cursor",        icon = "󰛔 " },

        -- Code / clipboard detail
        { "<leader>ca", desc = "Code action",                   icon = " " },
        { "<leader>cr", desc = "Rename symbol",                 icon = "󰑕 " },
        { "<leader>cf", desc = "Format buffer",                 icon = " " },
        { "<leader>cl", desc = "Trigger linting",               icon = " " },
        { "<leader>cx", desc = "chmod +x (make executable)",    icon = " " },
        { "<leader>cp", desc = "Copy absolute path",            icon = " " },
        { "<leader>cP", desc = "Copy relative path",            icon = " " },

        -- Oil detail
        { "<leader>o",  desc = "Oil: open current directory",   icon = " " },
        { "<leader>O",  desc = "Oil: open (floating window)",   icon = " " },
        { "-",          desc = "Oil: open parent directory",    icon = " " },

        -- Lists / trouble detail
        { "<leader>xx", desc = "Diagnostics (Trouble)",         icon = " " },
        { "<leader>xX", desc = "Buffer diagnostics (Trouble)",  icon = " " },
        { "<leader>xo", desc = "Open quickfix list",            icon = " " },
        { "<leader>xc", desc = "Close quickfix list",           icon = " " },
        { "<leader>xq", desc = "Quickfix (Trouble)",            icon = " " },
        { "<leader>xl", desc = "LSP definitions (Trouble)",     icon = " " },

        -- Non-leader groups
        { "g",  group = "goto",     icon = " " },
        { "]",  group = "next",     icon = " " },
        { "[",  group = "prev",     icon = " " },
        { "s",  group = "flash",    icon = "⚡" },
      })
    end,
  },
}
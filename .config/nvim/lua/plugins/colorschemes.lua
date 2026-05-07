-- lua/plugins/colorschemes.lua
return {

  -- ── Catppuccin ─────────────────────────────────────────────────────────────
  -- Already downloaded by LazyVim. This spec properly configures it.
  -- Flavours available: latte (light), frappe, macchiato, mocha (darkest)
  -- Switch with :colorscheme catppuccin-frappe / catppuccin-macchiato / catppuccin-mocha
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,    -- load before everything else
    opts = {
      flavour = "mocha",  -- default flavour when you do :colorscheme catppuccin
      background = {
        light = "latte",
        dark  = "mocha",
      },
      transparent_background = false,
      integrations = {
        cmp        = true,
        gitsigns   = true,
        neotree    = true,
        telescope  = { enabled = true },
        treesitter = true,
        which_key  = true,
        mason      = true,
        noice      = true,
        notify     = true,
        mini       = { enabled = true },
      },
    },
  },

  -- ── Bamboo ──────────────────────────────────────────────────────────────────
  -- Two variants:
  --   :colorscheme bamboo          → Regular (balanced green-tinted dark)
  --   :colorscheme bamboo-vulgaris → Vulgaris (warmer, more contrast)
  {
    "ribru17/bamboo.nvim",
    priority = 1000,
    opts = {
      style           = "vulgaris",  -- default variant ("bamboo" or "vulgaris")
      transparent     = false,
      dim_inactive    = false,
      diagnostics = {
        undercurl   = true,
        background  = true,
      },
    },
  },



-- ── Kanagawa ────────────────────────────────────────────────────────────────
  -- Three variants:
  --   :colorscheme kanagawa          → defaults to wave
  --   :colorscheme kanagawa-wave     → dark blue/grey (classic)
  --   :colorscheme kanagawa-dragon   → darker, warmer brown tones
  --   :colorscheme kanagawa-lotus    → light variant
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      theme      = "wave",       -- default variant
      transparent = false,
      dimInactive = false,
      terminalColors = true,
    },
  },

  -- ── Gruvbox ──────────────────────────────────────────────────────────────────
  -- Using gruvbox-material (better maintained than the original gruvbox.nvim)
  -- Three contrast levels: "hard" | "medium" | "soft"
  --   :colorscheme gruvbox-material
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background        = "medium"  -- hard / medium / soft
      vim.g.gruvbox_material_foreground        = "material" -- material / mix / original
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic      = 1
      vim.g.gruvbox_material_enable_bold        = 1
    end,
  },

}


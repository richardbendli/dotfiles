-- lua/plugins/colorschemes.lua
return {

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
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

  -- Bamboo
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



-- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      theme       = "wave",       -- default variant
      transparent = false,
      dimInactive = false,
      terminalColors = true,
    },
  },

  -- Gruvbox
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


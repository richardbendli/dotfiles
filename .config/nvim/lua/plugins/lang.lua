return {

  -- mason.nvim: formatters and linters ONLY
  {
    "mason-org/mason.nvim", -- renamed williamboman/mason.nvim
    opts = {
      ensure_installed = {
        -- Python
        "black",       -- formatter
        "isort",       -- import sorter
        "flake8",      -- linter

        -- Bash
        "shfmt",       -- formatter
        "shellcheck",  -- linter

        -- Terraform
        "tflint",      -- linter

        -- TOML — taplo handles both formatting AND the LSP.
        "taplo",

        -- YAML / Markdown / JSON
        "prettier",

        -- Dockerfile
        "hadolint",    -- linter
      },
    },
  },

  -- nvim-lspconfig: server configs
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text     = { prefix = "●", source = "if_many" },
        float            = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
      },
      inlay_hints = { enabled = true },

      servers = {

        -- Python: basedpyright
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode       = "standard",
                autoSearchPaths        = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions  = true,
                diagnosticSeverityOverrides = {
                  reportMissingImports      = "warning",
                  reportMissingModuleSource = "none",
                  reportUndefinedVariable   = "error",
                },
              },
            },
          },
        },

        -- Bash: bashls
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
          settings = {
            bashIde = {
              globPattern                  = "**/*@(.sh|.inc|.bash|.command)",
              enableSourceErrorDiagnostics = true,
              shellcheckPath               = "shellcheck",
            },
          },
        },

        -- Terraform: terraformls
        -- Requires: terraform binary in PATH + `terraform init` run in project
        terraformls = {
          filetypes = { "terraform", "tf", "terraform-vars" },
        },

        -- Markdown: marksman
        marksman = {},

        -- YAML: yamlls
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = true,
                url    = "https://www.schemastore.org/api/json/catalog.json",
              },
              schemas = {
                -- Explicit overrides when auto-detection misses
                ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = {
                  "*.cf.yaml", "*.cf.yml", "cloudformation*.yaml",
                },
                ["https://json.schemastore.org/github-workflow.json"] = {
                  ".github/workflows/*.yml",
                  ".github/workflows/*.yaml",
                },
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                  "docker-compose*.yml",
                  "docker-compose*.yaml",
                },
              },
              validate   = true,
              hover      = true,
              completion = true,
            },
          },
        },

        -- Dockerfile
        dockerls = {},

      },

      -- setup: per-server custom behaviour
      setup = {
        -- Auto-detect Python virtualenv
        basedpyright = function(_, opts)
          opts.before_init = function(_, config)
            local venv_dirs = { ".venv", "venv", "env", ".env" }
            for _, d in ipairs(venv_dirs) do
              local python = vim.fn.getcwd() .. "/" .. d .. "/bin/python"
              if vim.fn.executable(python) == 1 then
                config.settings = config.settings or {}
                config.settings.basedpyright = config.settings.basedpyright or {}
                config.settings.basedpyright.pythonPath = python
                break
              end
            end
          end
        end,
      },
    },

    -- Extra keymaps on LspAttach
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group    = vim.api.nvim_create_augroup("user_lsp_keymaps", { clear = true }),
        callback = function(event)
          local buf = event.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs,
              { buffer = buf, silent = true, desc = "LSP: " .. desc })
          end

          map("n", "gD",         vim.lsp.buf.declaration,    "Go to Declaration")
          map("i", "<C-k>",      vim.lsp.buf.signature_help, "Signature Help")
          map("v", "<leader>ca", vim.lsp.buf.code_action,    "Code Action (range)")
          map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
            "Add Workspace Folder")
          map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
            "Remove Workspace Folder")
          map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "List Workspace Folders")

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Toggle inlay hints
          if client and vim.lsp.inlay_hint
            and client.supports_method("textDocument/inlayHint") then
            map("n", "<leader>uh", function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
              )
            end, "Toggle Inlay Hints")
          end

          -- Highlight all references to the symbol under cursor on hold
          if client and client.supports_method("textDocument/documentHighlight") then
            local hl = vim.api.nvim_create_augroup(
              "user_lsp_hl_" .. buf, { clear = true }
            )
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = buf, group = hl,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = buf, group = hl,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },

  -- conform.nvim: formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Python: isort must run first (sorts imports), then black formats
        python    = { "isort", "black" },
        -- Bash/sh
        sh        = { "shfmt" },
        bash      = { "shfmt" },
        zsh       = { "shfmt" },
        -- Terraform: terraform_fmt is built-in, no binary install needed
        terraform = { "terraform_fmt" },
        tf        = { "terraform_fmt" },
        -- TOML: taplo — fast, handles pyproject.toml, Cargo.toml, etc.
        toml      = { "taplo" },
        -- JSON, YAML, Markdown: prettier handles all three cleanly
        json      = { "prettier" },
        yaml      = { "prettier" },
        markdown  = { "prettier" },
        -- Strip trailing whitespace on every filetype as a final pass
        ["*"]     = { "trim_whitespace" },
      },
      formatters = {
        -- 4-space indent, indent switch/case statements
        shfmt = { prepend_args = { "-i", "4", "-ci" } },
        -- Match black's line length
        black = { prepend_args = { "--line-length", "88" } },
        -- black-compatible import sorting
        isort = { prepend_args = { "--profile", "black" } },
      },
    },
  },

  -- nvim-lint: linters
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python     = { "flake8" },
        sh         = { "shellcheck" },
        bash       = { "shellcheck" },
        terraform  = { "tflint" },
        dockerfile = { "hadolint" },
        -- JSON/TOML/YAML: no linters (yamlls handles YAML validation via LSP)
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      -- Explicit bash mode so shellcheck applies bash-specific rules
      lint.linters.shellcheck.args = {
        "--shell=bash", "--external-sources", "--format=json", "-",
      }

      -- Run linting on save and when leaving insert mode.
      -- Guards against missing binaries so it works across all your distros
      -- without erroring when a linter isn't installed yet.
      vim.api.nvim_create_autocmd(
        { "BufWritePost", "BufReadPost", "InsertLeave" },
        {
          group = vim.api.nvim_create_augroup("user_nvim_lint", { clear = true }),
          callback = function()
            local ft      = vim.bo.filetype
            local linters = opts.linters_by_ft[ft] or {}
            for _, name in ipairs(linters) do
              local linter = lint.linters[name]
              local cmd    = type(linter) == "table" and linter.cmd or name
              if vim.fn.executable(cmd) == 1 then
                lint.try_lint(name)
              end
            end
          end,
        }
      )

      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
      end, { desc = "Trigger linting" })
    end,
  },

  -- Treesitter: parsers for all languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- Already in LazyVim: lua, python, bash, markdown, yaml, json
        "terraform",   -- .tf files
        "hcl",         -- .hcl files (Packer, Consul, Vault)
        "dockerfile",
        "toml",        -- pyproject.toml, Cargo.toml, tool configs
        "ini",         -- AWS ~/.aws/config and ~/.aws/credentials
        "comment",     -- highlights TODO/FIXME/NOTE tokens everywhere
        "regex",       -- useful when reading/writing bash patterns
      })
      return opts
    end,
  },

  -- vim-terraform: filetype detection + fmt
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "tf", "hcl" },
    config = function()
      vim.g.terraform_align       = 1
      vim.g.terraform_fmt_on_save = 0  -- conform handles formatting
    end,
  },

  -- venv-selector: switch Python virtualenvs interactively
  -- Without this, basedpyright will use system Python even if you have a
  -- venv active in the shell. VenvSelect syncs it inside Neovim.
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    branch = "regexp",
    ft     = "python",
    cmd    = "VenvSelect",
    keys   = {
      { "<leader>vs", "<cmd>VenvSelect<CR>",       desc = "Select Python venv" },
      { "<leader>vS", "<cmd>VenvSelectCached<CR>", desc = "Use cached venv" },
    },
    opts = {
      auto_refresh = true,
      name         = { "venv", ".venv", "env", ".env" },
    },
  },

  -- harpoon2: fast file bookmarking
  -- Keymaps live in keymaps.lua. Spec here handles install + setup.
  {
    "ThePrimeagen/harpoon",
    branch       = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
  },
}

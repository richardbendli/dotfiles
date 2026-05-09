return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Optional but recommended: renders markdown in chat buffer
      "MeanderingProgrammer/render-markdown.nvim",
    },
    event = "VeryLazy",
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>",  mode = { "n", "v" }, desc = "AI: Toggle chat" },
      { "<leader>ai", "<cmd>CodeCompanion<CR>",             mode = { "n", "v" }, desc = "AI: Inline assist" },
      { "<leader>aa", "<cmd>CodeCompanionChat Add<CR>",     mode = { "n", "v" }, desc = "AI: Add to chat" },
      { "<leader>aq", "<cmd>CodeCompanionCmd<CR>",          mode = { "n", "v" }, desc = "AI: Quick ask" },
      { "<leader>ap", "<cmd>CodeCompanionActions<CR>",      mode = { "n", "v" }, desc = "AI: Prompt actions" },
      -- Visual mode shortcuts
      { "ga",         "<cmd>CodeCompanionChat Add<CR>",     mode = "v",          desc = "AI: Add selection to chat" },
      { "ge",         "<cmd>CodeCompanionActions<CR>",      mode = "v",          desc = "AI: Explain code" },
      { "gf",         "<cmd>CodeCompanion fix<CR>",         mode = "v",          desc = "AI: Fix code" },
    },
    opts = {

      -- Adapters: define all your AI backends
      adapters = {

        -- Local: Ollama
        ollama_coder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "ollama_coder",
            schema = {
              model = {
                default = "qwen2.5-coder:32b",
              },
              num_ctx = {
                default = 16384,    -- context window
              },
              temperature = {
                default = 0.1,      -- low = more deterministic code output
              },
            },
          })
        end,

        ollama_chat = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "ollama_chat",
            schema = {
              model = {
                default = "llama3.3:70b",
              },
              num_ctx = {
                default = 16384,
              },
              temperature = {
                default = 0.7,
              },
            },
          })
        end,

        -- Cloud fallback: Anthropic Claude
        -- Requires: export ANTHROPIC_API_KEY="sk-ant-..."
        -- Uses Claude Sonnet by default
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = {
                default = "claude-sonnet-4-5",
              },
            },
          })
        end,

        -- Cloud fallback: OpenAI
        -- Requires: export OPENAI_API_KEY="sk-..."
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              model = {
                default = "gpt-4o",
              },
            },
          })
        end,
      },

      -- Strategies: which adapter each mode uses by default
      strategies = {
        -- Chat window (<leader>ac)
        chat = {
          adapter = "ollama_coder",   -- change to "anthropic" to use Claude
          keymaps = {
            send            = { modes = { n = "<CR>",  i = "<C-s>" } },
            close           = { modes = { n = "q",    i = "<C-c>" } },
            stop            = { modes = { n = "<C-c>" } },
            clear           = { modes = { n = "<C-x>" } },
            -- Switch model inside a chat
            change_adapter  = { modes = { n = "<C-m>" }, desc = "Switch AI model" },
          },
          -- Slash commands available inside the chat buffer
          slash_commands = {
            ["buffer"]  = { opts = { provider = "telescope" } },
            ["file"]    = { opts = { provider = "telescope" } },
            ["symbols"] = { opts = { provider = "telescope" } },
          },
        },
        -- Inline assist (<leader>ai)
        inline = {
          adapter = "ollama_coder",
        },
        -- Agent / tool use
        agent = {
          adapter = "ollama_coder",
        },
      },

      -- Display
      display = {
        -- Chat window appears as a buffer split on the right
        chat = {
          window = {
            layout  = "vertical",   -- "vertical" | "horizontal" | "float" | "buffer"
            width   = 0.35,         -- 35% of screen width
            border  = "rounded",
          },
          -- Show token usage in chat
          show_token_count    = true,
          show_settings       = false,   -- hide model settings header
        },
        -- Inline diff: how AI suggestions appear in code
        inline = {
          layout = "vertical",
        },
        -- Action palette style
        action_palette = {
          provider = "telescope",
        },
      },

      -- Prompt library
      -- These show up in <leader>ap (CodeCompanionActions)
      -- Pre-built prompts for workflow
      prompt_library = {

        ["Explain Code"] = {
          strategy = "chat",
          description = "Explain what the selected code does",
          opts = { auto_submit = true },
          prompts = {
            { role = "user", content = function(context)
              return "Explain this " .. context.filetype .. " code:\n\n```"
                .. context.filetype .. "\n"
                .. require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                .. "\n```"
            end },
          },
        },

        ["Fix Code"] = {
          strategy = "chat",
          description = "Fix bugs or errors in selected code",
          opts = { auto_submit = true },
          prompts = {
            { role = "user", content = function(context)
              return "Fix any bugs or issues in this " .. context.filetype .. " code. "
                .. "Explain what was wrong and show the fixed version:\n\n```"
                .. context.filetype .. "\n"
                .. require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                .. "\n```"
            end },
          },
        },

        ["Write Tests"] = {
          strategy = "chat",
          description = "Generate tests for selected code",
          opts = { auto_submit = true },
          prompts = {
            { role = "user", content = function(context)
              return "Write tests for this " .. context.filetype .. " code:\n\n```"
                .. context.filetype .. "\n"
                .. require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                .. "\n```"
            end },
          },
        },

        ["Refactor"] = {
          strategy = "chat",
          description = "Refactor selected code for readability and performance",
          opts = { auto_submit = true },
          prompts = {
            { role = "user", content = function(context)
              return "Refactor this " .. context.filetype .. " code for better readability, "
                .. "performance and best practices. Show the refactored version:\n\n```"
                .. context.filetype .. "\n"
                .. require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                .. "\n```"
            end },
          },
        },

        ["Add Comments"] = {
          strategy = "inline",
          description = "Add docstrings and inline comments",
          opts = { auto_submit = true },
          prompts = {
            { role = "user", content = function(context)
              return "Add clear docstrings and inline comments to this "
                .. context.filetype .. " code:\n\n```"
                .. context.filetype .. "\n"
                .. require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                .. "\n```"
            end },
          },
        },

        ["AWS Help"] = {
          strategy = "chat",
          description = "Ask about AWS services, CLI, or CloudFormation",
          opts = { auto_submit = false },
          prompts = {
            { role = "system", content = "You are an AWS expert. Help with AWS services, "
              .. "CLI commands, IAM policies, CloudFormation, and best practices. "
              .. "Always mention security implications." },
            { role = "user",   content = "AWS question: " },
          },
        },

        ["Bash Script Review"] = {
          strategy = "chat",
          description = "Review bash script for bugs, security and best practices",
          opts = { auto_submit = true },
          prompts = {
            { role = "user", content = function(context)
              return "Review this bash script for bugs, security issues, and best practices. "
                .. "Check for: unquoted variables, missing error handling, "
                .. "shellcheck warnings, and security concerns:\n\n```bash\n"
                .. require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                .. "\n```"
            end },
          },
        },
      },
    },
  },
}
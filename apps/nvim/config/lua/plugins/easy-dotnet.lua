return {
  -- lazy.nvim
  {
    ft = { "cs", "csproj", "sln", "slnx" },
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "folke/snacks.nvim",
    },
    config = function()
      local dotnet = require("easy-dotnet")
      dotnet.setup({
        managed_terminal = {
          auto_hide = true, -- auto hides terminal if exit code is 0
          auto_hide_delay = 1000, -- delay before auto hiding, 0 = instant
          mappings = {
            next_tab = { lhs = "<Tab>", desc = "Next terminal tab" },
            prev_tab = { lhs = "<S-Tab>", desc = "Previous terminal tab" },
            new_terminal = { lhs = "+", desc = "New user terminal" },
            close_terminal = { lhs = "X", desc = "Close current terminal tab" },
            hide_panel = { lhs = "q", desc = "Hide terminal panel" },
          },
        },
        -- Optional configuration for external terminals (matches nvim-dap structure)
        external_terminal = nil,
        projx_lsp = {
          enabled = true,
        },
        lsp = {
          enabled = true, -- Enable builtin roslyn lsp
          preload_roslyn = true, -- Start loading roslyn before any buffer is opened
          roslynator_enabled = true, -- Automatically enable roslynator analyzer
          easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
          auto_refresh_codelens = false,
          suggest_updates = false, -- Periodically suggest roslyn-language-server updates
          analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
          razor = {
            enabled = false,
            html = { enabled = false },
          },
          config = {},
        },
        csproj_mappings = true,
        fsproj_mappings = false,
        auto_bootstrap_namespace = {
          --block_scoped, file_scoped
          type = "block_scoped",
          enabled = false,
          use_clipboard_json = {
            behavior = "prompt", --'auto' | 'prompt' | 'never',
            register = "+", -- which register to check
          },
        },
        -- "telescope" | "fzf" | "snacks" | "basic"
        --  snacks -> fzf -> telescope ->  basic
        picker = "telescope",
        diagnostics = {
          default_severity = "error",
          setqflist = false,
        },
      })

      -- Example command
      vim.api.nvim_create_user_command("Secrets", function()
        dotnet.secrets()
      end, {})
    end,
  },
}

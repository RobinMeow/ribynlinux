-- Shows how to use the DAP plugin to debug your code.
--
-- dotnet in easy-dotnet https://github.com/GustavEikaas/easy-dotnet.nvim/blob/main/docs/debugging.md

-- show virtual text of values https://github.com/theHamsta/nvim-dap-virtual-text?utm_source=chatgpt.com

return {
  enabled = true,
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio", -- required nvim-dap-ui dependency
    -- ensure installed, i think?
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- 'leoluz/nvim-dap-go', -- GO debugger
  },
	-- stylua: ignore
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue", },
    { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint", },
    { "<leader><F9>", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Set Breakpoint", },
    { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over", },
    { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into", },
    { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out", },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Debug: Run to cursor", },
    { "<leader>dh", function() require("dap").hover() end, desc = "Debug: Hover value under cursor", },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    { "<F7>", function() require("dapui").toggle() end, desc = "Debug: See last session result.", },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
      -- I specified the dap's in init.lua
      ensure_installed = {
        -- "netcoredbg", -- dotnet
        -- "codelldb", -- c/c++/rust/zig
      },
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup({
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    })

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
    vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
    local breakpoint_icons = vim.g.have_nerd_font
        and {
          Breakpoint = "",
          BreakpointCondition = "",
          BreakpointRejected = "",
          LogPoint = "",
          Stopped = "",
        }
      or {
        Breakpoint = "●",
        BreakpointCondition = "⊜",
        BreakpointRejected = "⊘",
        LogPoint = "◆",
        Stopped = "⭔",
      }
    for type, icon in pairs(breakpoint_icons) do
      local tp = "Dap" .. type
      local hl = (type == "Stopped") and "DapStop" or "DapBreak"
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Install golang specific config
    -- require("dap-go").setup({
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has("win32") == 0,
    --   },
    -- })

    -- c/c++/rust/zig specific dap config
    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
      -- On windows you may have to uncomment this:
      -- detached = false,
    }

    -- INFO: Codelldb Manual: https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
    dap.configurations.cpp = {
      {
        -- Common default config apparently
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    -- can use the same config
    dap.configurations.rust = dap.configurations.cpp
    -- dap.configurations.c = dap.configurations.cpp
    -- dap.configurations.zig = dap.configurations.cpp
  end,
}

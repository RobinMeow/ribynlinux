-- Shows how to use the DAP plugin to debug your code.
--
-- dotnet in easy-dotnet https://github.com/GustavEikaas/easy-dotnet.nvim/blob/main/docs/debugging.md

-- show virtual text of values https://github.com/theHamsta/nvim-dap-virtual-text

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

    {
      "theHamsta/nvim-dap-virtual-text",
      -- build = ":TSUpdate", -- threw an error on WSL. maybe would have on native linux as well. tho docs says to do it.
      config = function()
        require("nvim-dap-virtual-text").setup({
          enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = false, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true, -- show stop reason when stopped for exceptions
          commented = false, -- prefix virtual text with comment string
          only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
          all_references = false, -- show virtual text on all all references of the variable (not only definitions)
          clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
          --- A callback that determines how a variable is displayed or whether it should be omitted
          --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
          --- @param buf number
          --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
          --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
          --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
          --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
          display_callback = function(variable, buf, stackframe, node, options)
            -- by default, strip out new line characters
            if options.virt_text_pos == "inline" then
              return " = " .. variable.value:gsub("%s+", " ")
            else
              return variable.name .. " = " .. variable.value:gsub("%s+", " ")
            end
          end,
          -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
          -- virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
          virt_text_pos = "eol",

          -- disable experimental features (as of 2026-07-07)
          all_frames = false,
          virt_lines = false,
          virt_text_win_col = nil,
        })
      end,
    },
  },
	-- stylua: ignore
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    { "<F3>", function() require("dap").close() end, desc = "Debug: Close", },
    { "<F4>", function() require("dap").restart() end, desc = "Debug: Restart", },

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
      automatic_installation = false,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
      ensure_installed = {}, -- not using this. install using mason
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

    -- NOTE: its being overrien, annoyingly
    -- dap.adapters.netcoredbg = {
    --   type = "executable",
    --   command = vim.fn.exepath("netcoredbg"),
    --   args = { "--interpreter=vscode" },
    -- } -- needed for debugging Program.cs
    -- dap.adapters.coreclr = dap.adapters.netcoredbg -- needed for debugging unit test
    -- dap.configurations.cs = {
    --   {
    --     type = "coreclr",
    --     name = "microslop",
    --     program = function()
    --       return require("microslop").build_dll_path()
    --     end,
    --     request = "attach",
    --     cwd = "${workspaceFolder}",
    --   },
    -- }

    -- WARN: test if those work. copied from here: https://github.com/Mathijs-Bakker/godotdev.nvim/blob/master/lua/godotdev/dap.lua
    -- GDScript adapter for non-csharp projects
    -- dap.adapters.godot = {
    --   type = "server",
    --   host = "127.0.0.1",
    --   port = 6006, -- when a godot project opens it says "Debug adapter server started on port 6006" (and gdscript lsp on 6005)
    -- }
    -- dap.configurations.gdscript = {
    --   {
    --     type = "godot",
    --     request = "launch",
    --     name = "Launch scene",
    --     project = "${workspaceFolder}",
    --     launch_scene = true,
    --   },
    -- }

    -- WARN: not really needed they were overriden anyways
    --
    -- -- INFO: Codelldb Manual: https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
    -- -- c/c++/rust/zig specific dap config
    -- dap.adapters.codelldb = {
    --   type = "executable",
    --   command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
    -- }
    -- dap.configurations.cpp = {
    --   -- NOTE: default config for running files with main entry block
    --   {
    --     -- Common default config apparently
    --     name = "Launch file",
    --     type = "codelldb",
    --     request = "launch",
    --     program = function()
    --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --     end,
    --     cwd = "${workspaceFolder}",
    --     stopOnEntry = false,
    --   },
    --
    --   -- NOTE: working example for running a specific unreal project (not well reuseable, but good enough since I never debug anyways)
    --   -- {
    --   --   name = "Unreal Editor (Launch Project)",
    --   --   type = "codelldb",
    --   --   request = "launch",
    --   --   -- Point this to where your source-built or installed engine lives on Linux
    --   --   program = "${env:HOME}/UnrealEngine/Engine/Binaries/Linux/UnrealEditor",
    --   --   args = {
    --   --     -- point this to your project
    --   --     "${env:HOME}/ue/UENetworkTests/UENetworkTests.uproject",
    --   --     "-log", -- Crucial on Linux: spawns a separate native terminal window for live engine stdout logs
    --   --   },
    --   --   cwd = "${workspaceFolder}",
    --   --   stopOnEntry = false,
    --   -- },
    -- }
    -- -- can use the same config
    -- dap.configurations.rust = dap.configurations.cpp
    -- -- dap.configurations.c = dap.configurations.cpp
    -- -- dap.configurations.zig = dap.configurations.cpp
  end,
}

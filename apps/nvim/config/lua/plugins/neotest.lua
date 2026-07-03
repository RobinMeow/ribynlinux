return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      --base deps
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- adapters
      {
        "mrcjkb/rustaceanvim",
        -- To avoid being surprised by breaking changes, I recommend you set a version range
        version = "^9",
        -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
        -- No need for lazy.nvim to lazy-load it.
        lazy = false, -- lazy loaded by default within the plugin
      }, -- does not requre setup call
      -- "https://github.com/rcasia/neotest-bash",
      "https://github.com/marilari88/neotest-vitest",
      -- WARN: when enabeling other adapters check their gh, if a specific setup call is required
      -- "https://github.com/nvim-neotest/neotest-jest",
      -- "https://github.com/thenbe/neotest-playwright",
      -- "https://github.com/nsidorenco/neotest-vstest",
      -- "https://github.com/Issafalcon/neotest-dotnet",
      -- "https://github.com/rouge8/neotest-rust",
      -- "https://github.com/alfaix/neotest-gtest",
      -- "https://github.com/orjangj/neotest-ctest",
      -- "https://github.com/rcasia/neotest-bash",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest")({
            -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
            filter_dir = function(name, rel_path, root)
              return name ~= "node_modules"
            end,
            -- vitestCommand = "npm run test --",
            -- vitestCommand = function(position_id)
            --   return "npm test -- --include " .. position_id
            -- end,
          }),

          -- require("neotest-jest")({
          --   jestCommand = "npm test --",
          --   jestArguments = function(defaultArguments, context)
          --     return defaultArguments
          --   end,
          --   jestConfigFile = "custom.jest.config.ts",
          --   env = { CI = true },
          --   cwd = function(path)
          --     return vim.fn.getcwd()
          --   end,
          --   isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
          -- }),

          -- require("neotest-playwright"), -- https://github.com/thenbe/neotest-playwright

          -- require("neotest-vstest"), -- dotnet https://github.com/nsidorenco/neotest-vstest
          -- require("neotest-dotnet"), -- dotnet https://github.com/Issafalcon/neotest-dotnet

          -- require("neotest-rust"), -- https://github.com/rouge8/neotest-rust
          -- require("neotest-gtest"), -- C++ Google Test https://github.com/alfaix/neotest-gtest
          -- require("neotest-ctest"), -- C/C++ CTest https://github.com/orjangj/neotest-ctest
          -- require("neotest-bash"), -- https://github.com/rcasia/neotest-bash
        },
      })
    end,
			 -- stylua: ignore
    keys = {
      { "<leader>nr", "<cmd>Neotest run<cr>", { desc = "Run test under cursor" } },
      { "<leader>no", "<cmd>Neotest output<cr>", { desc = "Show output of test under cursor" } },
      { "<leader>ns", "<cmd>Neotest summary<cr>", { desc = "Toggle summray" } },
      {
        "<leader>na",
        "<cmd>lua require('neotest').run.run({ suite = true })<cr>",
        { desc = "Run test suite of current buffer" },
      },
			-- NOTE: saw those in a post, but cant bother putting them in right now
			-- { "<leader>t",  "", desc = "+test" },
			-- { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,              desc = "Run File" },
			-- { "<leader>tT", function() require("neotest").run.run(require("utils.path").current_project_root()) end,       desc = "Run Project" },
			-- { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end,                    desc = "Run All" },
			-- { "<leader>tr", function() require("neotest").run.run() end,                                desc = "Run Nearest" },
			-- { "<leader>tl", function() require("neotest").run.run_last() end,                           desc = "Run Last" },
			-- { "<leader>ts", function() require("neotest").summary.toggle() end,                         desc = "Toggle Summary" },
			-- { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
			-- { "<leader>tO", function() require("neotest").output_panel.toggle() end,                    desc = "Toggle Output Panel" },
			-- { "<leader>tS", function() require("neotest").run.stop() end,                               desc = "Stop" },
			-- { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,         desc = "Toggle Watch" },
		},
  },
}

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
      "https://github.com/rcasia/neotest-bash",
      "https://github.com/marilari88/neotest-vitest",
      "https://github.com/thenbe/neotest-playwright",
      "https://github.com/nsidorenco/neotest-vstest",
      "https://github.com/Issafalcon/neotest-dotnet",
      "https://github.com/rouge8/neotest-rust",
      "https://github.com/alfaix/neotest-gtest",
      "https://github.com/orjangj/neotest-ctest",
      "https://github.com/rcasia/neotest-bash",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest"), -- https://github.com/marilari88/neotest-vitest
          require("neotest-playwright"), -- https://github.com/thenbe/neotest-playwright

          require("neotest-vstest"), -- dotnet https://github.com/nsidorenco/neotest-vstest
          require("neotest-dotnet"), -- dotnet https://github.com/Issafalcon/neotest-dotnet

          require("neotest-rust"), -- https://github.com/rouge8/neotest-rust
          require("neotest-gtest"), -- C++ Google Test https://github.com/alfaix/neotest-gtest
          require("neotest-ctest"), -- C/C++ CTest https://github.com/orjangj/neotest-ctest
          require("neotest-bash"), -- https://github.com/rcasia/neotest-bash
        },
      })
    end,
  },
}

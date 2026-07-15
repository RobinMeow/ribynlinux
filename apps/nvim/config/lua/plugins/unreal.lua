return {
  {
    "taku25/UnrealDev.nvim",
    -- Define all plugins in the development suite.
    -- You can remove any plugins you don't use.
    dependencies = {
      {
        "taku25/UNL.nvim", -- Core Library
        build = "cargo build --release --manifest-path scanner/Cargo.toml",
        -- TODO: timeout doesnt work. use cd ~/.local/share/nvim/lazy/UNL.nvim/ and `cargo build --release --manifest-path scanner/Cargo.toml` to build manually
        -- timeout = 300, -- 5min (for PC WHITE it tool 186.51s user 7.06s system 113% cpu 2:50.85 total)
        lazy = false,
      },
      "taku25/UEP.nvim", -- Project Explorer
      "taku25/UEA.nvim", -- Asset (Blueprint) Inspector
      "taku25/UBT.nvim", -- Build Tool
      "taku25/UCM.nvim", -- Class Manager
      "taku25/ULG.nvim", -- Log Viewer
      "taku25/USH.nvim", -- Unreal Shell
      {
        "taku25/UNX.nvim", -- Logical View
        dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons",
        },
      },
      "taku25/UDB.nvim", -- Debug
      {
        -- It ensures that .uproject files are correctly read as json,
        -- and provides dedicated Tree-sitter highlighting for Unreal Shaders (.ush/.usf)
        -- and Unreal C++ macros (UCLASS, UPROPERTY, etc.).
        "taku25/USX.nvim",
        lazy = false,
      },

      -- UI Plugins (Optional)
      "nvim-telescope/telescope.nvim",

      -- WARN: lets see if it works with my snacks
      -- "j-hui/fidget.nvim",

      -- WARN: already have lualine configured
      -- "nvim-lualine/lualine.nvim",

      -- WARN: tree-sitter-manager is still maintained, well aware of treesitter being archived
      -- TODO: i should probably migrate my config
      {
        "romus204/tree-sitter-manager.nvim",
        opts = {
          ensure_installed = { "cpp", "ushader", "verse" },
          highlight = { "cpp", "ushader", "verse" },
          border = "rounded",
          languages = {
            cpp = {
              install_info = {
                url = "https://github.com/taku25/tree-sitter-cpp",
                use_repo_queries = true,
              },
            },
            ushader = {
              install_info = {
                url = "https://github.com/taku25/tree-sitter-unreal-shader",
                use_repo_queries = true,
              },
            },
            verse = {
              install_info = {
                url = "https://github.com/taku25/tree-sitter-verse",
                use_repo_queries = true,
              },
            },
          },
        },
        config = function(_, opts)
          vim.filetype.add({
            extension = {
              verse = "verse",
              usf = "ushader",
              ush = "ushader",
            },
          })
          require("tree-sitter-manager").setup(opts)
          -- TODO: make a pull request for chaning MyTreesitter to something more specific for this plugin
          local group = vim.api.nvim_create_augroup("MyTreesitter", { clear = true })
          vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = opts.highlight,
            callback = function(args)
              vim.treesitter.start(args.buf)
            end,
          })
        end,
      },
    },
    opts = {
      -- INFO: these abbreviations are killing me:
      -- UNL.nvim (Required core library)
      -- Plugins: (Install any or all of these)
      --   UDB.nvim (Debug)
      --   blink-cmp-unreal (Completion)
      setup_modules = {
        UBT = true, -- UBT.nvim (Build Tool)
        UEP = true, -- UEP.nvim (Project Explorer)
        ULG = true, -- ULG.nvim (Log Viewer)
        USH = true, -- USH.nvim (Unreal Shell)
        UCM = true, -- UCM.nvim (Class Manager)
        UEA = true, -- UEA.nvim (Asset (BP) Inspector)
        UNX = true, -- UNX.nvim (Logical View)
      },
    },
  },

  -- Individual Plugin Settings
  --{ 'taku25/UBT.nvim', opts = { ... } },
  --{ 'taku25/UEP.nvim', opts = { ... } },
  --{ 'taku25/UEA.nvim', opts = { ... } },
}

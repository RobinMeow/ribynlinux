return {
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons", enabled = true }, -- requires nerd font
    },
    config = function()
      -- open available keybinds help:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?

      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup({
        -- `:help telescope.setup()`
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        pickers = {
          colorscheme = { enable_preview = true },
          diagnostics = {
            theme = "ivy", -- dropdown, ivy, cursor
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")

      local function SearchCurrentDirectory()
        local current_file = vim.fn.expand("%:p")

        -- Check if the buffer is a file
        if current_file == "" or vim.fn.filereadable(current_file) == 0 then
          -- Fallback to regular find_files
          builtin.find_files()
          return
        end

        local currWorkingDir = vim.fn.expand("%:p:h")

        builtin.find_files(require("telescope.themes").get_ivy({
          cwd = currWorkingDir,
          prompt_title = "Current Buffer's Directory",
        }))
      end

      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps (which_key i => C-/ n => ?)" })
      local function search_files()
        builtin.find_files({ file_ignore_patterns = { "assets/" } })
      end
      vim.keymap.set("n", "<leader>sf", search_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", '<leader>s"', builtin.registers, { desc = '[S]earch ["] registers' })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[s]earch [b]uffers" })
      vim.keymap.set("n", "<leader>se", function()
        builtin.find_files({ hidden = false, no_ignore = true, no_ignore_parent = true })
      end, { desc = "[s]earch [e]verything (hidden, ignored and ignored by parent)" })
      vim.keymap.set("n", "<leader>scd", SearchCurrentDirectory, { desc = "[S]earch [C]urrent [D]irectory" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>s*", builtin.grep_string, { desc = "[s]earch [w]ord under cursor" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Old Files ("." for repeat)' })
      vim.keymap.set("n", "<leader>scs", builtin.colorscheme, { desc = "[s]earch [c]olor[s]cheme" })

      -- two examples of reusing the exisitng builtins differently
      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] fuzzy search current buffer" })

      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "[S]earch [/] in Open Files" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[S]earch [N]eovim files" })

      vim.cmd("highlight TelescopeBorder guibg=none")
    end,
  },
}

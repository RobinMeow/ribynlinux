return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      -- TODO: Oil: configure preview
      -- preview_win = {
      --   update_on_cursor_moved = true,
      --   preview_method = "fast_scratch",
      -- },
      keymaps = {
        -- remove
        ["<C-h>"] = false,
        ["<C-l>"] = false,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations
    lazy = false,
  },
}

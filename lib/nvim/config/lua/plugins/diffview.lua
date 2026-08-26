return {
  {
    "sindrets/diffview.nvim",
    opts = {
      view = {
        default = { layout = "diff2_horizontal" },
        file_history = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_mixed" },
      },
      file_panel = {
        listing_style = "tree", -- One of 'list' or 'tree'
        tree_options = { -- Only applies when listing_style is 'tree'
          flatten_dirs = true, -- Flatten dirs that only contain one single dir
          folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
        },
        win_config = { -- See |diffview-config-win_config|
          position = "left",
          width = 35,
          win_opts = {},
        },
      },
      win_config = { -- See |diffview-config-win_config|
        position = "left",
        width = 35,
        win_opts = {},
      },
      -- WARN: tricking diffview into thinking the binary executable is hg
      -- to prevent checkhealth warning
      -- hg(mercurial) is a different version control, which I do not use.
      hg_cmd = { os.getenv("RIBYN_ROOT") .. "/lib/nvim/hg_cmd_dummy.sh" },
    },
  },
}

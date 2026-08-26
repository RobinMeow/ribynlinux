return {
  {
    "Willem-J-an/adopure.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      -- NOTE: export environment variable AZURE_DEVOPS_EXT_PAT
      -- in azure devops you can use the website to generate a PAT
      -- (Personal Access Token)
      vim.g.adopure = {}
    end,
  },
}

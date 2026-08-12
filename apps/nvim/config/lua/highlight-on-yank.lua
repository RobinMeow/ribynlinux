vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
    -- NOTE: hl_op throws often. Ill wait for kickstart or neovim to fix it.
    -- kickstart also still uses on_yank, for this reason prolly
    -- vim.hl.hl_op()
  end,
})

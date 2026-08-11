local m = {}

function m.open_angular_file(target_ext)
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == "" then
    return
  end

  -- Strip any existing Angular suffix from the file path
	-- stylua: ignore
  local base = current_file
    :gsub("%.spec%.ts$", "")
    :gsub("%.ts$", "")
    :gsub("%.html$", "")
    :gsub("%.scss$", "")
    :gsub("%.css$", "")

  local target_file = base .. target_ext

  -- Fallback to .css if .scss doesn't exist
  if target_ext == ".scss" and vim.fn.filereadable(target_file) == 0 then
    local css_file = base .. ".css"
    if vim.fn.filereadable(css_file) == 1 then
      target_file = css_file
    end
  end

  -- Open the file if it exists
  if vim.fn.filereadable(target_file) == 1 then
    vim.cmd("edit " .. vim.fn.fnameescape(target_file))
  else
    vim.notify("File not found: " .. vim.fn.fnamemodify(target_file, ":t"), vim.log.levels.WARN)
  end
end

function m.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("AngularBufferSwitcher", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then
        return
      end
      if client.name ~= "angularls" and client.name ~= "cssls" then
        return
      end

      local bufnr = args.buf
      local opts = {
        buffer = bufnr, -- keymaps are only active for this buffer
        silent = true,
      }

      vim.keymap.set("n", "<leader>at", function()
        m.open_angular_file(".ts")
      end, vim.tbl_extend("force", opts, { desc = "Angular: Go to .ts" }))
      vim.keymap.set("n", "<leader>ah", function()
        m.open_angular_file(".html")
      end, vim.tbl_extend("force", opts, { desc = "Angular: Go to .html" }))
      vim.keymap.set("n", "<leader>ac", function()
        m.open_angular_file(".scss")
      end, vim.tbl_extend("force", opts, { desc = "Angular: Go to .scss/.css" }))
      vim.keymap.set("n", "<leader>as", function()
        m.open_angular_file(".spec.ts")
      end, vim.tbl_extend("force", opts, { desc = "Angular: Go to .spec.ts" }))

      -- just for quick debugging, works.
      -- vim.notify("Angular keymaps loaded for buffer via " .. client.name, vim.log.levels.INFO)
    end,
  })
end

return m

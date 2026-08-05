-- TODO: load angular keymaps only for angular files
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

return m

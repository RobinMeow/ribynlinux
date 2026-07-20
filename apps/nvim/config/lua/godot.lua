-- WARN: dont think I need this. my serach already respects gitignore etc,
-- tho those files might not be gitignored
-- ignore godot .uid files in wild menus
-- vim.cmd("set wildignore+=**.uid")

-- TODO: also interesting feature
-- spell check
-- vim.cmd("set spell")
-- vim.cmd("set spelllang=en_us,cjk")
-- vim.cmd("set spellsuggest=best,9")

-- TODO: I dont think I have this one yet.
-- spaces instead of tabs
-- vim.cmd("set expandtab")

-- WARN: not planning on writing gdscript, but I have it doesnt force me to use tabs
-- except for godot gdscript files
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = { "*.gd" },
--   command = "set noexpandtab",
-- })

-- TODO: dont use netrw but, still need to check if I need to filter those files out
-- hide godot files
-- vim.g.netrw_list_hide = "\\.uid"

-- TODO: interesting one
-- close all buffers and reopen last edited buffer
-- vim.keymap.set("n", "cab", ":%bd|e#|bd#<CR><C-O><CR>")

-- TODO: im still fine without
-- quick-list navigation
-- vim.keymap.set("n", "<leader>cn", ":cnext<CR>")
-- vim.keymap.set("n", "<leader>ct", ":cprev<CR>")
-- vim.keymap.set("n", "<leader>cc", ":cclose<CR>")
-- vim.keymap.set("n", "<leader>cf", ":cnfile<CR>")

-- TODO: is this checking for root?
-- paths to check for project.godot file
local function gd_log(msg) end
local paths_to_check = { "/", "/../" }
local is_godot_project = false
local godot_project_path = ""
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. "project.godot") then
    is_godot_project = true
    godot_project_path = cwd .. value
    print("[Godot] Found project:" .. godot_project_path)
    break
  end
end

local server_pipe = godot_project_path .. "server.pipe"
-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(server_pipe)
-- start server, if not already running
if is_godot_project and not is_server_running then
  print("[Godot] Starting server at: " .. server_pipe)

  local ok, err = pcall(vim.fn.serverstart, server_pipe)
  if ok then
    print("[Godot] Server started at: " .. server_pipe)
  else
    print("[Godot][ERROR] Failed to start server: " .. tostring(err))
  end
elseif is_godot_project and is_server_running then
  print("[Godot] Server is already running at: " .. server_pipe)
end

if is_godot_project then
  -- WARN: here were a lot of debugging Breakpoints keymaps, but they didnt appeal to me
end

-- TODO: checkout gdtoolscipt and gdscriptformattter (already set up the install for them)

local m = {}

function m.open_picker()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local commands = {
    "AdoPure load context",
    "AdoPure load threads",
    "AdoPure open quickfix",
    "AdoPure open thread_picker",
    "AdoPure open new_thread",
    "AdoPure open existing_thread",
    "AdoPure submit comment",
    "AdoPure submit vote",
    "AdoPure submit thread_status",
    "AdoPure submit delete_comment",
    "AdoPure submit edit_comment",
  }

  pickers
    .new({}, {
      prompt_title = "AdoPure Commands",
      finder = finders.new_table({
        results = commands,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            vim.cmd(selection[1])
          end
        end)
        return true
      end,
    })
    :find()
end

function m.setup()
  vim.keymap.set({ "n", "v" }, "<leader>ad", m.open_picker, { desc = "AdoPure Commands" })
end

return m

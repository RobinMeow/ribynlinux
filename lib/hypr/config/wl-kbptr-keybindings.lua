local m = {}

-- stylua: ignore
function m.setup()
  local key = require("key")

  local prev_cursor_settings = nil
  hl.bind("SUPER + C", function()
    prev_cursor_settings = hl.get_config("cursor")
    hl.config({
      cursor = {
        inactive_timeout = 0, -- do not hide cursor after timeouts (0ms)
        hide_on_key_press = false, -- do not hide cursor on keyboard presses
      },
    })
    hl.dispatch(hl.dsp.submap("cursor"))
  end, { desc = "enter cursor submap" })

  hl.define_submap("cursor", function()
    -- Jump cursor to a position
    key.bind(
      "A",
      -- disable submap to allow typing letters, spawn the grid,
      -- type the letters, cursor jumps, re-enter the submap for clicking keymaps or exit
      function()
        local reset_submap = "hyprctl dispatch 'hl.dsp.submap(\"reset\")'"
				-- INFO: https://github.com/moverest/wl-kbptr
        -- spawn grid and wait for typed letters, then teleport the cursor. exit proccess.
        local wlkbptr_floating = "wl-kbptr -o modes=floating,click -o mode_floating.source=detect"
        local enter_submap = "hyprctl dispatch 'hl.dsp.submap(\"cursor\")'"
        hl.dispatch(hl.dsp.exec_cmd(reset_submap .. " && " .. wlkbptr_floating .. " && " .. enter_submap))
      end,
      { desc = "cursor: enter wl-kbptr floating" }
    )
    -- TODO: bisect tile mode
    -- TODO: split tile mode
		key.bind(
      "Z",
      function()
        local reset_submap = "hyprctl dispatch 'hl.dsp.submap(\"reset\")'"
        local wlkbptr_tilemode = "wl-kbptr -o modes=tile,click"
        local enter_submap = "hyprctl dispatch 'hl.dsp.submap(\"cursor\")'"
        hl.dispatch(hl.dsp.exec_cmd(reset_submap .. " && " .. wlkbptr_tilemode .. " && " .. enter_submap))
      end,
      { desc = "cursor: enter wl-kbptr tile" }
    )
    -- TODO: submap visualiser

    -- Cursor movement
		local big_step = 150
    key.bind("Y", hl.dsp.exec_cmd("wlrctl pointer move -" .. big_step .. " 0"), { repeating = true, desc = "cursor: move pointer left " .. big_step .. "u" })
    key.bind("U", hl.dsp.exec_cmd("wlrctl pointer move 0 ".. big_step), { repeating = true ,  desc = "cursor: move pointer down " .. big_step .. "u" })
    key.bind("I", hl.dsp.exec_cmd("wlrctl pointer move 0 -" .. big_step), { repeating = true, desc = "cursor: move pointer up " .. big_step .. "u" })
    key.bind("O", hl.dsp.exec_cmd("wlrctl pointer move " .. big_step .. " 0"), { repeating = true , desc = "cursor: move pointer right " .. big_step .. "u"})

    key.bind("H", hl.dsp.exec_cmd("wlrctl pointer move -10 0"), { repeating = true, desc = "cursor: move pointer left" })
    key.bind("J", hl.dsp.exec_cmd("wlrctl pointer move 0 10"), { repeating = true ,  desc = "cursor: move pointer down" })
    key.bind("K", hl.dsp.exec_cmd("wlrctl pointer move 0 -10"), { repeating = true, desc = "cursor: move pointer up" })
    key.bind("L", hl.dsp.exec_cmd("wlrctl pointer move 10 0"), { repeating = true , desc = "cursor: move pointer right"})

		local small_step = 1
    key.bind("N", hl.dsp.exec_cmd("wlrctl pointer move -" .. small_step .. " 0"), { repeating = true, desc = "cursor: move pointer left " .. small_step .. "u" })
    key.bind("M", hl.dsp.exec_cmd("wlrctl pointer move 0 ".. small_step), { repeating = true ,  desc = "cursor: move pointer down " .. small_step .. "u" })
    key.bind("COMMA", hl.dsp.exec_cmd("wlrctl pointer move 0 -" .. small_step), { repeating = true, desc = "cursor: move pointer up " .. small_step .. "u" })
    key.bind("PERIOD", hl.dsp.exec_cmd("wlrctl pointer move " .. small_step .. " 0"), { repeating = true , desc = "cursor: move pointer right " .. small_step .. "u"})

    key.bind("F", hl.dsp.exec_cmd("wlrctl pointer click left"), { repeating = true, desc = "cursor: LMB click" })
    key.bind("D", hl.dsp.exec_cmd("wlrctl pointer click middle"), { repeating = true, desc = "cursor: middle click" })
    key.bind("S", hl.dsp.exec_cmd("wlrctl pointer click right"), { repeating = true, desc = "cursor: RMB click" })

    key.bind("G", hl.dsp.exec_cmd("wlrctl pointer scroll 30 0"), { repeating = true, desc = "cursor: scroll up" })
    key.bind("T", hl.dsp.exec_cmd("wlrctl pointer scroll -30 0"), { repeating = true, desc = "cursor: scroll down" })

    key.bind("E", hl.dsp.exec_cmd("wlrctl pointer scroll 0 -30"), { repeating = true , desc = "cursor: scroll left" })
    key.bind("R", hl.dsp.exec_cmd("wlrctl pointer scroll 0 30"), { repeating = true,  desc = "cursor: scroll right"  })

    local reset = function()
      hl.config({ cursor = prev_cursor_settings })
      hl.dispatch(hl.dsp.submap("reset"))
    end
    key.bind("Q", reset, { desc = "cursor: exit submap" })
    key.bind("ESCAPE", reset, { desc = "cursor: exit submap" })
  end)
end

return m

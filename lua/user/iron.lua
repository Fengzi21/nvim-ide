local status_ok, iron = pcall(require, "iron.core")
if not status_ok then
  return
end


iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        command = {"zsh"}
      },
      python = {
        command = { "ipython" },
        format = require("iron.fts.common").bracketed_paste
      }
    },
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = require("iron.view").split("40%", {
      number = false
    }),
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<space><space>sc",
    visual_send = "<space><space>sc",
    send_file = "<space><space>sf",
    send_line = "<space><space>sl",
    send_mark = "<space><space>sm",
    mark_motion = "<space><space>mc",
    mark_visual = "<space><space>mc",
    remove_mark = "<space><space>md",
    cr = "<space><space>s<cr>",
    interrupt = "<space><space>s<space>",
    exit = "<space><space>sq",
    clear = "<space><space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  }
}


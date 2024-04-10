local status_ok, iron = pcall(require, "iron.core")
if not status_ok then
	return
end

iron.setup({
	config = {
		-- Whether a repl should be discarded or not
		scratch_repl = true,
		-- Your repl definitions come here
		repl_definition = {
			sh = {
				command = { "zsh" },
			},
			python = {
				command = { "ipython" },
				format = require("iron.fts.common").bracketed_paste,
			},
		},
		-- How the repl window will be displayed
		-- See below for more information
		repl_open_cmd = require("iron.view").split.vertical.botright("40%", {
			number = false,
			relativenumber = false,
		}),
	},
	-- Iron doesn't set keymaps by default anymore.
	-- You can set them here or manually add keymaps to the functions in iron.core
	-- I prefer set keymaps by which-key
	keymaps = {
		-- send_motion = "<space><space>sM",
		-- visual_send = "<space><space>sv",
		send_motion = "ctr", -- change to this for jupytext
		visual_send = "ctr",
		send_file = "<space><space>sf",
		send_line = "<space><space>sl",
		send_mark = "<space><space>sm",
		mark_motion = "<space><space>mm",
		mark_visual = "<space><space>mv",
		remove_mark = "<space><space>md",
		cr = "<space><space>se", -- Set Enter (Carriage Return) to repl
		interrupt = "<space><space>si",
		exit = "<space><space>sq",
		clear = "<space><space>sc",
	},
	-- If the highlight is on, you can change how it looks
	-- For the available options, check nvim_set_hl
	highlight = {
		italic = true,
	},
})

vim.cmd([[
  set laststatus=3
  highlight WinSeparator guibg=None
]])

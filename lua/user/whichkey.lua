local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<CR>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	-- mode = "n", -- NORMAL mode
	mode = { "n", "v", "x" },
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["a"] = { "<cmd>Alpha<CR>", "Alpha" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
		"Buffers",
	},
	["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },

	-- DAP
	d = {
		name = "DAP",
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
		c = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
		i = { "<cmd>lua require'dap'.step_into()<CR>", "Step into" },
		o = { "<cmd>lua require'dap'.step_over()<CR>", "Step over" },
		O = { "<cmd>lua require'dap'.step_out()<CR>", "Step out" },
		r = { "<cmd>lua require'dap'.repl.toggle()<CR>", "REPL toggle" },
		l = { "<cmd>lua require'dap'.run_last()<CR>", "Run last" },
		u = { "<cmd>lua require'dapui'.toggle()<CR>", "UI toggle" },
		t = { "<cmd>lua require'dap'.terminate()<CR>", "Terminate" },
	},

	-- For Telescope
	-- live_grep requires ripgrep
	f = {
		name = "Telescope",
		f = { "<cmd>Telescope find_files<CR>", "Find Files" },
		F = { "<cmd>Telescope live_grep theme=ivy<CR>", "Find Text" },
		g = { "<cmd>Telescope live_grep<CR>", "Grep" },
		G = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Grep Args" },
		b = { "<cmd>Telescope buffers<CR>", "Lists open buffers" },
		h = { "<cmd>Telescope help_tags<CR>", "Lists available help tags" },
		P = { "<cmd>Telescope projects<CR>", "Projects" },
		s = { "<cmd>Telescope grep_string<CR>", "Grep String" },
		E = { "<cmd>Telescope emoji<CR>", "Emoji Search" },
		e = { "<cmd>Telescope file_browser<CR>", "File Browser" },
	},

	-- ["f"] = {
	--   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
	--   "Find files",
	-- },

	F = { "<cmd>Telescope live_grep theme=ivy<CR>", "Find Text" },

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<CR>", "Compile" },
		i = { "<cmd>PackerInstall<CR>", "Install" },
		s = { "<cmd>PackerSync<CR>", "Sync" },
		S = { "<cmd>PackerStatus<CR>", "Status" },
		u = { "<cmd>PackerUpdate<CR>", "Update" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<CR>",
			"Diff",
		},
	},

	i = {
		name = "IconPick",
		n = { "<cmd>IconPickerNormal<CR>", "Pick and insert icon to the buffer (normal)" },
		i = { "<cmd>IconPickerInsert<CR>", "Pick and insert icon to the buffer (insert)" },
		y = { "<cmd>IconPickerYank<CR>", "Pick and yank icon to register" },
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
		d = {
			"<cmd>Telescope lsp_document_diagnostics<CR>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<CR>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
		i = { "<cmd>LspInfo<CR>", "Info" },
		I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
			"Workspace Symbols",
		},
	},

	m = {
		name = "Markdown",
		p = { "<cmd>MarkdownPreview<CR>", "Preview Markdown" },
		s = { "<cmd>MarkdownPreviewStop<CR>", "Stop Markdown Preview" },
		t = { "<cmd>MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },
		f = { "<cmd>Glow %<CR>", "Glow Preview File" },
		b = { "<cmd>Glow<CR>", "Glow Preview Current Buffer" },
	},

	r = {
		name = "Repl",
		o = { "<cmd>IronRepl<CR>", "Start a repl" },
		r = { "<cmd>IronRestart<CR>", "Restart the current repl" },
		f = { "<cmd>IronFocus<CR>", "Focus on the repl" },
		h = { "<cmd>IronHide<CR>", "Hide the repl window" },
		w = { "<cmd>IronWatch<CR>", "Send to repl after writing" },
		s = {
			name = "Send",
			e = { "<cmd>lua require('iron.core').send(nil, string.char(13))<CR>", "Carriage Return" },
			i = { "<cmd>lua require('iron.core').send(nil, string.char(03))<CR>", "Interrupt" },
			q = { "<cmd>lua require('iron.core').close_repl()<CR>", "Quit" },
			c = { "<cmd>lua require('iron.core').send(nil, string.char(12))<CR>", "Clear" },
			M = { "<cmd>lua require('iron.core').send_motion()<CR>", "Send motion" },
			v = { "<cmd>lua require('iron.core').visual_send()<CR>", "Send visual" },
			f = { "<cmd>lua require('iron.core').send_file()<CR>", "Send file" },
			l = { "<cmd>lua require('iron.core').send_line()<CR>", "Send line" },
			m = { "<cmd>lua require('iron.core').send_mark()<CR>", "Send mark" },
		},
		m = {
			name = "Mark",
			m = { "<cmd>lua require('iron.core').mark_motion()<CR>", "Mark motion" },
			v = { "<cmd>lua require('iron.core').mark_visual()<CR>", "Mark visual" },
			d = { "<cmd>lua require('iron.marks').drop_last()<CR>", "Mark drop" },
		},
	},

	R = {
		name = "Run",
		p = { "<cmd>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>", "Python" },
		l = { "<cmd>:w<CR>:exec '!lua' shellescape(@%, 1)<CR>", "Lua" },
	},

	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
		M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
		R = { "<cmd>Telescope registers<CR>", "Registers" },
		k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
		C = { "<cmd>Telescope commands<CR>", "Commands" },
	},

	t = {
		name = "Terminal",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		n = { "<cmd>lua _NODE_TOGGLE()<CR>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<CR>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<CR>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<CR>", "Python" },
		i = { "<cmd>lua _IPYTHON_TOGGLE()<CR>", "IPython" },
		f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
		h = { "<cmd>ToggleTerm direction=horizontal<CR>", "Horizontal" },
		v = { "<cmd>ToggleTerm direction=vertical<CR>", "Vertical" },
		a = { "<cmd>ToggleTermToggleAll<CR>", "Toggle all terminal" },
		s = {
			name = "Send/Set",
			n = { "<cmd>ToggleTermSetName<CR>", "Set terminal name" },
			l = { "<cmd>ToggleTermSendCurrentLine 7<CR>", "Send current line to ipython" },
			v = { "<cmd>ToggleTermSendVisualLines 7<CR>", "Send visual lines to ipython" },
			b = { "<cmd>ToggleTermSendVisualSelection 7<CR>", "Send visually selected block to ipython" },
		},
	},

	T = {
		name = "Toggle",
		l = { "<cmd>set invrelativenumber<CR>", "Toggle relative number" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- Color table for highlights
-- stylua: ignore
local colors = require('tokyonight.colors').setup()

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,

	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,

	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		section_separators = "",
		component_separators = "",
		globalstatus = true,
		-- theme = 'monokai'
		-- theme = {
		--   -- We are going to use lualine_c an lualine_x as left and
		--   -- right section. Both are highlighted by c theme .  So we
		--   -- are just setting default looks o statusline
		-- normal = { c = { fg = colors.fg, bg = colors.bg } },
		-- inactive = { c = { fg = colors.fg, bg = colors.bg } },
		--   },
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_v = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

local mode_color = {
	n = colors.red,
	i = colors.green,
	v = colors.blue,
	[""] = colors.blue,
	V = colors.blue,
	c = colors.magenta,
	no = colors.red,
	s = colors.orange,
	S = colors.orange,
	[""] = colors.orange,
	ic = colors.yellow,
	R = colors.violet,
	Rv = colors.violet,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	["r?"] = colors.cyan,
	["!"] = colors.red,
	t = colors.yellow,
}

ins_left({
	function()
		vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
		return "▊"
	end,
	color = "LualineMode",
	-- color = { fg = colors.blue, gui = 'bold' },
	padding = { left = 0, right = 0 },
})

ins_left({
	"mode",
	color = "LualineMode",
	padding = { left = 1, right = 1 },
})

-- neovim mode component
ins_left({
	function()
		-- auto change color according to neovim modes
		vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
		return ""
	end,
	color = "LualineMode",
	padding = { left = 0, right = 1 },
})

-- filesize component
-- ins_left {
--   'filesize',
--   cond = conditions.buffer_not_empty,
--   padding = { left = 0, right = 1 },
-- }

-- filename component
ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = "bold" },
	padding = { left = 0, right = 1 },
})

-- curser location
ins_left({
	"location",
	padding = { left = 1, right = 1 },
})

ins_left({
	"progress",
	color = { fg = colors.fg, gui = "bold" },
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", hint = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
	-- always_visible = true,
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
	function()
		return "%="
	end,
})

-- Lsp server name.
ins_left({
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = colors.cyan, gui = "bold" },
})

-- Tab Size
ins_right({
	function()
		return "⇥ " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	end,
})

-- Add components to right sections
ins_right({
	"o:encoding", -- option component same as &encoding in viml
	-- fmt = string.upper,
	cond = conditions.hide_in_width,
	color = { fg = colors.blue, gui = "bold" },
})

-- file type
ins_right({
	"filetype",
	-- fmt = string.upper,
	icons_enabled = true,
	color = { fg = colors.blue, gui = "bold" },
})

-- git branch
ins_right({
	"branch",
	icon = "",
	color = { fg = colors.violet, gui = "bold" },
})

-- git diff status
ins_right({
	"diff",
	symbols = { added = " ", modified = "柳 ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		-- auto change color according to neovim modes
		vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
		return "▊"
	end,
	color = "LualineMode",
	-- color = { fg = colors.blue, gui = 'bold' },
	padding = { left = 1 },
})

-- Now don't forget to initialize lualine
lualine.setup(config)

local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
	return
end

transparent.setup({
	extra_groups = { -- table/string: additional groups that should be cleared
		-- In particular, when you set it to 'all', that means all available groups

		-- example of akinsho/nvim-bufferline.lua
		"BufferLineTabClose",
		"BufferlineBufferSelected",
		"BufferLineFill",
		"BufferLineBackground",
		"BufferLineSeparator",
		"BufferLineIndicatorSelected",

		"TelescopeMatching",
		"TelescopeSelection",
		"TelescopePromptTitle",
		"TelescopePromptPrefix",
		"TelescopePromptCounte",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopeResultsTitle",
		"TelescopeResultsNormal",
		"TelescopeResultsBorder",
		"TelescopePreviewTitle",
		"TelescopePreviewNormal",
		"TelescopePreviewBorder",
	},
	exclude_groups = {}, -- table: groups you don't want to clear
})

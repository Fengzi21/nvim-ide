local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	return
end

require("colorizer").setup({
	filetypes = {
		"*", -- Highlight all files, but customize some others.
		css = { css = true }, -- Enable parsing rgb(...) functions in css.
	},
})

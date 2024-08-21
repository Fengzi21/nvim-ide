-- local colorscheme = "tokyonight"
local colorscheme = "monokai"
-- local colorscheme = "monokai_pro"
-- local colorscheme = "monokai_soda"

vim.g.python_highlight_all = 1

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme" .. colorscheme .. "not found!")
	return
end

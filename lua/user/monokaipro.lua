-- See more config @ https://gitlab.com/__tpb/monokai-pro.nvim


-- Example config in Lua
-- vim.g.monokaipro_filter = "machine"
vim.g.monokaipro_filter = "classic"
vim.g.monokaipro_italic_functions = true
vim.g.monokaipro_sidebars = { "vista_kind", "packer" }
vim.g.monokaipro_flat_term = true

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.monokaipro_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
vim.cmd[[colorscheme monokaipro]]

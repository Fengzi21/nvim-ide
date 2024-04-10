-- https://github.com/papitz/nvim/blob/main/lua/plugins/vimtex.lua

vim.g.vimtex_view_general_viewer = "zathura"

if vim.loop.os_uname().sysname == "Darwin" then
	vim.g.vimtex_view_method = "skim"
	vim.g.vimtex_view_skim_sync = 1
elseif vim.fn.has("win64") or vim.fn.has("win32") or vim.fn.has("win16") then
	vim.g.vimtex_view_general_viewer = "SumatraPDF"
	vim.cmd("let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'")
else
	vim.g.vimtex_view_method = "zathura"
end

vim.cmd("let g:vimtex_toc_config = {'layer_status': {'label':0, 'include':0}, 'show_help':0}")
vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_enabled = 1
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_quickfix_open_on_waning = 0
vim.g.vimtex_compiler_silent = 0
vim.g.vimtex_complete_enabled = 0
-- vim.opt.conceallevel = 1
-- vim.g.tex_conceal = "abdmg"
vim.cmd([[autocmd Filetype tex setl spell spelllang=de,en
    autocmd Filetype tex setl updatetime=250]])

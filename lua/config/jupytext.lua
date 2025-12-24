-- See more @ https://www.maxwellrules.com/misc/nvim_jupyter.html

vim.g.jupytext_fmt = "py"
vim.g.jupytext_style = "percent"

-- Send cell to IronRepl and move to next cell.
-- Depends on the text object defined in vim-textobj-hydrogen
-- You first need to be connected to IronRepl

-- Run the cell started by `# %%` with `]x`
-- defined in keymap.lua
-- nmap ]x ctrih/^# %%<CR><CR>

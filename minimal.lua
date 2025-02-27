-- :h[elp] option to see help
vim.opt.backup = false                                 -- creates a backup file
vim.opt.writebackup = false                            -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
-- ref: https://stackoverflow.com/questions/30691466/what-is-difference-between-vims-clipboard-unnamed-and-unnamedplus-settings
vim.opt.clipboard:append({ "unnamed", "unnamedplus" }) -- allows neovim to access the system clipboard
vim.opt.conceallevel = 0                               -- so that `` is visible in markdown files
vim.opt.hlsearch = true                                -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                              -- ignore case in search patterns
vim.opt.mouse = "a"                                    -- allow the mouse to be used in neovim
vim.opt.showmode = false                               -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                                -- always show tabs
vim.opt.smartcase = true                               -- smart case
vim.opt.swapfile = false                               -- creates a swapfile
vim.opt.termguicolors = true                           -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                              -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                                -- enable persistent undo
vim.opt.updatetime = 300                               -- faster completion (4000ms default)
vim.opt.smartindent = true                             -- make indenting smarter again
vim.opt.expandtab = true                               -- convert tabs to spaces
vim.opt.shiftwidth = 2                                 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                                    -- insert 2 spaces for a tab
vim.opt.cursorline = true                              -- highlight the current line
vim.opt.number = false                                 -- disable numbered lines
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.showcmd = true
vim.opt.ruler = false
vim.opt.numberwidth = 2                                          -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"                                       -- always show the sign column
vim.opt.wrap = false                                             -- wrap lines, display lines as one long line
vim.opt.scrolloff = 8                                            -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"                                -- the font used in graphical neovim applications
vim.opt.fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936" -- the encoding written to a file
vim.opt.encoding = "utf-8"
vim.opt.eol = true
vim.opt.fixeol = true

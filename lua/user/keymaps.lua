local keymap = vim.keymap.set -- Shorten function name
local opts = { silent = true } -- Silent keymap option

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Quick save
keymap("n", "<C-s>", "<cmd>w!<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("n", "<A-Down>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-Up>", "<Esc>:m .-2<CR>==", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Jupyter in Repl
vim.cmd([[
  nmap ]x ctrih/^# %%<CR><CR>
]])

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Quick save
keymap("i", "<C-s>", "<cmd>w!<CR>", opts)

-- Visual --
-- Better paste
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-Down>", ":m .+1<CR>==", opts)
keymap("v", "<A-Up>", ":m .-2<CR>==", opts)

-- Quick save
keymap("v", "<C-s>", "<cmd>w!<CR>", opts)

-- Run Selected in Repl
keymap("v", "<C-r>", "<cmd>lua require('iron.core').visual_send()<CR>", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Quick save
keymap("x", "<C-s>", "<cmd>w!<CR>", opts)

-- Run Selected in Repl
keymap("x", "<C-r>", "<cmd>lua require('iron.core').visual_send()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- DAP
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<CR>", opts)

-- Terminal
-- This not working
-- keymap("n", "<C-i>", "<cmd>ToggleTermSendCurrentLine 7<CR>", opts)
-- keymap("i", "<C-i>", "<cmd>ToggleTermSendCurrentLine 7<CR>", opts)
keymap("v", "<C-i>", "<cmd>ToggleTermSendVisualLines 7<CR>", opts)
keymap("x", "<C-i>", "<cmd>ToggleTermSendVisualSelection 7<CR>", opts)

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',


local keymap = vim.keymap.set  -- Shorten function name
local opts = { silent = true } -- Silent keymap option

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local rtn = {
  n = '',
  v = "<C-\\><C-N>",
  x = "<C-\\><C-N>",
  i = "<C-\\><C-N>",
  c = "<C-\\><C-N>",
  t = "<C-\\><C-N>",
}

-- Return to normal mode --
-- <C-\><C-N> works in all modes and performs better
-- ref: https://github.com/neovim/neovim/issues/7648
for _, m in pairs({ 'i', 'v', 'x', 't', 'c' }) do
  keymap(m, "<Esc>", rtn[m], opts)
  -- Press jk quickly
  if m == 'i' or m == 'c' or m == 't' then
    keymap(m, "jk", rtn[m], opts)
  end
end

-- Better window navigation --
for _, m in pairs({ 'n', 'v', 'x', 'i', 't' }) do
  -- Navigate --
  keymap(m, "<C-h>", rtn[m] .. "<C-w>h", opts)
  keymap(m, "<C-j>", rtn[m] .. "<C-w>j", opts)
  keymap(m, "<C-k>", rtn[m] .. "<C-w>k", opts)
  keymap(m, "<C-l>", rtn[m] .. "<C-w>l", opts)
  -- Close --
  if m ~= 'i' then
    keymap(m, "<C-q>", rtn[m] .. ":quit<CR>", opts)
  end
end

-- Resize --
for _, m in pairs({ 'n', 'v', 'x', 'i', 'c', 't' }) do
  -- Resize with arrows --
  keymap(m, "<C-Up>", rtn[m] .. ":resize +2<CR>", opts)
  keymap(m, "<C-Down>", rtn[m] .. ":resize -2<CR>", opts)
  keymap(m, "<C-Left>", rtn[m] .. ":vertical resize -2<CR>", opts)
  keymap(m, "<C-Right>", rtn[m] .. ":vertical resize +2<CR>", opts)
  -- Toggle fullscreen --
  keymap(m, "<C-f>", rtn[m] .. ":tab split<CR>", opts)
  keymap(m, "<C-b>", rtn[m] .. ":tab close<CR>", opts)
end

-- netrw --
-- use NvimTree instead
-- keymap('n', "<leader>e", ":Lex 30<CR>", opts)

-- Buffers --
for _, m in pairs({ 'n', 'v', 'x' }) do
  -- Navigate --
  keymap(m, "<S-l>", rtn[m] .. ":bnext<CR>", opts)
  keymap(m, "<S-h>", rtn[m] .. ":bprevious<CR>", opts)
  -- Close --
  keymap(m, "<S-q>", rtn[m] .. ":Bdelete!<CR>", opts)
end

-- Save and Move lines --
for _, m in pairs({ 'n', 'v', 'x', 'i' }) do
  -- Quick save --
  keymap(m, "<C-s>", rtn[m] .. ":w!<CR>", opts)

  -- Move lines up and down --
  local up_cmd, down_cmd
  if m == 'n' or m == 'i' then
    local _rtn = m == 'i' and "<C-\\><C-N>" or ''
    up_cmd = _rtn .. ":move .-2<CR>=="
    down_cmd = _rtn .. ":move .+1<CR>=="
  else
    up_cmd = ":move '<-2<CR>gv-gv"
    down_cmd = ":move '>+1<CR>gv-gv"
  end
  keymap(m, "<A-j>", down_cmd, opts)
  keymap(m, "<A-k>", up_cmd, opts)
  keymap(m, "<A-Down>", down_cmd, opts)
  keymap(m, "<A-Up>", up_cmd, opts)
end

-- Better paste --
keymap('v', "p", '"_dP', opts)
keymap('x', "p", '"_dP', opts)

-- Stay in indent mode --
keymap('v', "<", "<gv", opts)
keymap('v', ">", ">gv", opts)

-- Comment --
-- ref: https://github.com/numToStr/Comment.nvim
local toggle_linewise_current = function()
  return
      vim.v.count == 0
      and "<Plug>(comment_toggle_linewise_current)"
      or "<Plug>(comment_toggle_linewise_count)"
end
keymap('i', "<C-/>", rtn.i .. toggle_linewise_current(), opts)
keymap('n', "<C-/>", toggle_linewise_current(), opts)
keymap('x', "<C-/>", "<Plug>(comment_toggle_linewise_visual)", opts)
keymap('v', "<C-/>", "<Plug>(comment_toggle_linewise_visual)", opts)

-- Run in Repl --
-- ref: https://github.com/Vigemus/iron.nvim
keymap('i', "<C-e>", rtn.i .. ":lua require('iron.core').send_line()<CR>", opts)
keymap('n', "<C-e>", ":lua require('iron.core').send_line()<CR>", opts)
keymap('v', "<C-e>", ":lua require('iron.core').visual_send()<CR>", opts)
keymap('x', "<C-e>", ":lua require('iron.core').visual_send()<CR>", opts)

-- Run in IPython --
-- ref: https://github.com/akinsho/toggleterm.nvim
keymap('i', "<C-i>", rtn.i .. ":ToggleTermSendCurrentLine 7<CR>", opts)
keymap('n', "<C-i>", ":ToggleTermSendCurrentLine 7<CR>", opts)
keymap('x', "<C-i>", ":ToggleTermSendVisualLines 7<CR>", opts)
keymap('v', "<C-i>", ":ToggleTermSendVisualLines 7<CR>", opts)

-- Jupyter in Repl --
-- Run the cell started by `# %%` with `]x`
vim.cmd([[nmap ]x ctrih/^# %%<CR><CR>]])

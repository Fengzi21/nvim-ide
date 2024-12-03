local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

local fmt = string.format

-- config for powershell
if package.config:sub(1, 1) == "\\" then
  local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    ---@format disable-next
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }
  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
end

-- Function to be executed when a terminal is created
local function on_term_create(term)
  local ispy = string.find(string.lower(term.name), "python") ~= nil
  local ishs = string.find(string.lower(term.name), "ghci") ~= nil
  local islg = string.find(string.lower(term.name), "lazygit") ~= nil
  local isnode = string.find(string.lower(term.name), "node") ~= nil
  local ishtop = string.find(string.lower(term.name), "htop") ~= nil
  local isncdu = string.find(string.lower(term.name), "ncdu") ~= nil
  if (ispy or ishs or islg or isnode or ishtop or isncdu ) then
    return
  end
  vim.api.nvim_chan_send(
    term.job_id,
    'eval "$(oh-my-posh init zsh --config ~/.poshthemes/yfn.omp.json)" && clear\n'
  )
end

local conf = {
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "vertical" then
      return 70
    elseif term.direction == "horizontal" then
      return 10
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,   -- whether or not the open mapping applies in insert model
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = "float",      -- 'float' | 'horizontal' | 'vertical'
  close_on_exit = true,
  shell = vim.o.shell,
  on_create = function(term) on_term_create(term) end,
  auto_scroll = true,
  highlights = {
    Normal = {
      link = "Normal",
    },
    NormalFloat = {
      link = "Normal",
    },
    FloatBorder = {
      link = "Normal",
    },
    SignColumn = {
      link = "Normal",
    },
    SignColumnNC = {
      link = "Normal",
    },
    WinBar = {
      link = "Normal",
    },
    WinBarNC = {
      link = "Normal",
    },
  },
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
  winbar = {
    enabled = false,
    name_formatter = function(term)
      return fmt("%d:%s", term.id, term:_display_name())
    end,
  },
}

toggleterm.setup(conf)

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })
function _NODE_TOGGLE()
  node:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
function _NCDU_TOGGLE()
  ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })
function _HTOP_TOGGLE()
  htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })
function _PYTHON_TOGGLE()
  python:toggle()
end

local ipython = Terminal:new({
  cmd = "ipython",
  hidden = false,
  id = 7,
  count = 7,
  direction = "vertical",
  auto_scroll = true,
  name = "IPython",
  display_name = "IPython",
})
function _IPYTHON_TOGGLE()
  ipython:toggle()
end

local haskell = Terminal:new({
  cmd = "ghci",
  hidden = true,
  id = 9,
  count = 9,
  direction = "vertical",
  auto_scroll = true,
  name = "Haskell",
  display_name = "Haskell",
})
function _HASKELL_TOGGLE()
  haskell:toggle()
end

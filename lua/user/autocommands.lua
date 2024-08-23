-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = {
      "qf",
      "help",
      "man",
      "floaterm",
      "lspinfo",
      "lir",
      "lsp-installer",
      "null-ls-info",
      "tsplayground",
      "DressingSelect",
      "Jaq",
    },
    callback = function()
      vim.keymap.set("n", "q", ":close<CR>", { buffer = true })
      vim.opt_local.buflisted = false
    end,
  }
)

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd(
  { "User" },
  {
    pattern = { "AlphaReady" },
    callback = function()
      vim.opt_local.showtabline = 0
      vim.opt_local.laststatus = 0
    end,
  }
)

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  }
)

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Fixes Autocomment
vim.api.nvim_create_autocmd(
  { "BufWinEnter" },
  {
    callback = function()
      vim.cmd("set formatoptions-=cro")
    end,
  }
)

-- Highlight Yanked Text
vim.api.nvim_create_autocmd(
  { "TextYankPost" },
  {
    callback = function()
      vim.highlight.on_yank({ higroup = "Search", timeout = 100 })
    end,
  }
)

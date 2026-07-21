vim.loader.enable()

-- Neovim 0.10+ switched the health API from `vim.health.report_*` to
-- `vim.health.{start,ok,warn,info,error}`. Some plugins still use the old names.
do
  local health = vim.health
  if health and not health.report_start and health.start then
    health.report_start = health.start
    health.report_ok = health.ok
    health.report_warn = health.warn
    health.report_info = health.info
    health.report_error = health.error
  end
end

-- If you previously used native packages (Packer, manual pack/*/start), Neovim will
-- auto-load anything under stdpath('data')/site/pack/*/start.
-- Since this config is now fully lazy.nvim-managed, remove that packpath to avoid
-- double-loading old plugins (e.g. packer.bak leftovers).
vim.opt.packpath:remove(vim.fn.stdpath("data") .. "/site")


-- Disable providers we don't use to speed up startup time
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

require("config.python_host_prog")
require("config.options")
require("config.keymaps")
require("config.plugins")
require("config.cmp")
require("config.lsp")
require("config.dap")
require("config.telescope-setup")
require("config.treesitter")
require("config.autopairs")
require("config.comment")
require("config.gitsigns")
require("config.nvim-tree")
require("config.bufferline")
require("config.lualine")
require("config.toggleterm")
require("config.illuminate")
require("config.indentline")
require("config.alpha")
require("config.whichkey")
require("config.autocommands")
require("config.transparent")
require("config.monokaitheme")
require("config.colorscheme")
require("config.iron")
require("config.jupytext")
require("config.colorizer")
require("config.smartcc")
require("config.vimtex")
require("config.glow")
require("config.osc52")
require("config.markdown")
require("config.macro")
require("config.cmd")

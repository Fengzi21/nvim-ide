-- Plugin manager: lazy.nvim
-- NOTE: mason.nvim manages external binaries (LSP/DAP/formatters), not plugins.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
  return
end

lazy.setup({
  { "nvim-lua/plenary.nvim", lazy = false },
  { "nvim-lua/popup.nvim", lazy = false },

  { "numToStr/Comment.nvim", lazy = false },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },

  { "nvim-tree/nvim-web-devicons", lazy = false },
  { "nvim-tree/nvim-tree.lua", lazy = false },

  { "echasnovski/mini.nvim", version = "*", lazy = false },
  { "moll/vim-bbye", lazy = false },
  { "ahmedkhalf/project.nvim", lazy = false },
  { "lukas-reineke/indent-blankline.nvim", lazy = false },
  { "goolord/alpha-nvim", lazy = false },
  { "folke/which-key.nvim", lazy = false },

  { "m4xshen/smartcolumn.nvim", lazy = false },
  { "nvim-lualine/lualine.nvim", lazy = false },
  { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, lazy = false },

  { "folke/tokyonight.nvim", lazy = false },
  { "tanvirtin/monokai.nvim", lazy = false },
  { "vim-python/python-syntax", lazy = false },

  { "norcalli/nvim-colorizer.lua", lazy = false },
  { "windwp/nvim-autopairs", lazy = false },
  { "xiyaowong/nvim-transparent", lazy = false },

  { "hrsh7th/nvim-cmp", lazy = false },
  { "hrsh7th/cmp-buffer", lazy = false },
  { "hrsh7th/cmp-path", lazy = false },
  { "saadparwaiz1/cmp_luasnip", lazy = false },
  { "hrsh7th/cmp-nvim-lsp", lazy = false },
  { "hrsh7th/cmp-nvim-lua", lazy = false },
  { "onsails/lspkind-nvim", lazy = false },
  { "hrsh7th/cmp-emoji", lazy = false },

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    lazy = false,
  },
  { "rafamadriz/friendly-snippets", lazy = false },

  -- LSP (plugins) + Mason (binaries)
  { "neovim/nvim-lspconfig", lazy = false },
  { "williamboman/mason.nvim", lazy = false },
  { "williamboman/mason-lspconfig.nvim", lazy = false },
  { "neoclide/coc.nvim", branch = "release", lazy = false },

  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    lazy = false,
  },

  { "RRethy/vim-illuminate", lazy = false },

  {
    "nvimdev/lspsaga.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    lazy = false,
    config = function()
      require("lspsaga").setup({})
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    lazy = false,
  },
  { "nvim-telescope/telescope-live-grep-args.nvim", lazy = false },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = false },
  { "xiyaowong/telescope-emoji.nvim", lazy = false },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    lazy = false,
  },
  { "nvim-telescope/telescope-media-files.nvim", lazy = false },

  -- UI helpers
  { "stevearc/dressing.nvim", lazy = false },
  {
    "ziontee113/icon-picker.nvim",
    lazy = false,
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
  },

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    lazy = false,
  },
  { "ellisonleao/glow.nvim", lazy = false },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", lazy = false },

  -- Toggle terminal
  { "akinsho/toggleterm.nvim", lazy = false },

  -- Git
  { "lewis6991/gitsigns.nvim", lazy = false },

  -- DAP
  { "mfussenegger/nvim-dap", lazy = false },
  { "rcarriga/nvim-dap-ui", lazy = false },
  { "ravenxrz/DAPInstall.nvim", lazy = false },

  -- Interactive repl
  { "Vigemus/iron.nvim", lazy = false },

  -- Jupyter
  { "kana/vim-textobj-user", lazy = false },
  { "kana/vim-textobj-line", dependencies = { "kana/vim-textobj-user" }, lazy = false },
  {
    "GCBallesteros/vim-textobj-hydrogen",
    dependencies = { "kana/vim-textobj-user", "kana/vim-textobj-line" },
    lazy = false,
  },
  { "GCBallesteros/jupytext.nvim", lazy = false },

  -- LaTeX
  { "lervag/vimtex", lazy = false },

  -- Typst
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },

  -- Mojo
  { "igorgue/mojo.vim", lazy = false },

  -- YDict
  { "TimothyYe/vim-ydict", lazy = false },

  -- Clipboard
  { "ojroques/nvim-osc52", lazy = false },

  -- AI
  { "milanglacier/minuet-ai.nvim", lazy = false },
  {
    "Saghen/blink.cmp",
    dependencies = {
      "saghen/blink.lib", -- required for blink.cmp v2
      -- your other dependencies...
    },
    lazy = false,
  },
  { "github/copilot.vim", lazy = false },

  -- Mathematica
  { "voldikss/vim-mma", lazy = false },

  -- image
  {
    "adelarsq/image_preview.nvim",
    event = "VeryLazy",
    config = function()
      require("image_preview").setup()
    end,
  },
}, {
  -- Keep your previous preference for SSH git URLs.
  git = {
    url_format = "git@github.com:%s.git",
  },
  ui = {
    border = "rounded",
  },
})

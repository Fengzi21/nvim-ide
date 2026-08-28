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

  { "numToStr/Comment.nvim", lazy = false },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },

  { "nvim-tree/nvim-web-devicons", lazy = false },
  { "nvim-tree/nvim-tree.lua", lazy = false },

  { "echasnovski/mini.nvim", version = "*", lazy = false },
  { "moll/vim-bbye", lazy = false },
  { "lukas-reineke/indent-blankline.nvim", lazy = false },
  { "goolord/alpha-nvim", lazy = false },
  { "folke/which-key.nvim", lazy = false },

  { "m4xshen/smartcolumn.nvim", lazy = false },
  { "nvim-lualine/lualine.nvim", lazy = false },
  { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, lazy = false },

  { "folke/tokyonight.nvim", lazy = false },
  { "tanvirtin/monokai.nvim", lazy = false },

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
    -- `make install_jsregexp` requires `make` + a C compiler, which Windows
    -- doesn't ship by default (MSYS2/mingw or VS Build Tools needed). Only
    -- attempt it where `make` is actually available; LuaSnip still works
    -- fine without the jsregexp extension, just without regex triggers.
    build = (vim.fn.executable("make") == 1) and "make install_jsregexp" or nil,
    dependencies = { "rafamadriz/friendly-snippets" },
    lazy = false,
  },
  { "rafamadriz/friendly-snippets", lazy = false },

  -- LSP (plugins) + Mason (binaries)
  { "neovim/nvim-lspconfig", lazy = false },
  { "williamboman/mason.nvim", lazy = false },
  { "williamboman/mason-lspconfig.nvim", lazy = false },
  -- coc.nvim removed: it runs its own separate LSP client stack, which was
  -- duplicating/conflicting with the native vim.lsp + nvim-cmp setup
  -- already configured here (double diagnostics, competing keymaps).
  -- If you want coc.nvim's specific features back, do it as a deliberate
  -- swap-away-from-native-LSP, not alongside it.

  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    lazy = false,
  },

  { "RRethy/vim-illuminate", lazy = false },

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
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- Plain `make` isn't available on Windows out of the box; fall back to
    -- the project's documented CMake build there.
    build = (vim.fn.executable("make") == 1) and "make"
      or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    lazy = false,
  },
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
  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", lazy = false },

  -- Toggle terminal
  { "akinsho/toggleterm.nvim", lazy = false },

  -- Git
  { "lewis6991/gitsigns.nvim", lazy = false },

  -- DAP
  { "mfussenegger/nvim-dap", lazy = false },
  { "rcarriga/nvim-dap-ui", lazy = false },
  -- ravenxrz/DAPInstall.nvim is unmaintained; mason-nvim-dap.nvim plugs
  -- into the mason.nvim install you're already using for LSP servers.
  { "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim" }, lazy = false },

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
  -- minuet-ai.nvim removed: its setup() was already disabled in init.lua,
  -- yet cmp.lua still wired it in as a source/keymap — half-configured and
  -- inactive. blink.cmp removed too: it was never setup() anywhere, just
  -- dead weight loaded on every startup. nvim-cmp (below/cmp.lua) is the
  -- completion engine that's actually configured and working.
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
  -- Default to HTTPS so a fresh machine/CI runner without a GitHub SSH key
  -- configured can still bootstrap all plugins on the first run.
  -- If you do have SSH keys set up everywhere you use this config, you can
  -- switch back with:
  --   git = { url_format = "git@github.com:%s.git" },
  ui = {
    border = "rounded",
  },
})

-- See more details at
-- - https://github.com/tcmmichaelb139/.dotfiles
-- - https://github.com/LunarVim/nvim-basic-ide

local fn = vim.fn

-- Automatically install packer --
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git", "clone", "--depth", "1",
    -- "https://github.com/wbthomason/packer.nvim",
    "git@github.com:wbthomason/packer.nvim.git",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file --
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use --
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window --
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  config = {
    git = {
      default_url_format = "git@github.com:%s",
    },
  },
})

-- Install your plugins here --
return packer.startup(function(use)
  -- My plugins here --
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" })  -- Useful lua functions used by lots of plugins
  use({ "numToStr/Comment.nvim" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "nvim-tree/nvim-web-devicons" })
  use({ "nvim-tree/nvim-tree.lua" })
  use({ "echasnovski/mini.nvim", version = "*" })
  use({ "moll/vim-bbye" })
  use({ "ahmedkhalf/project.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} })
  use({ "goolord/alpha-nvim" })
  use({ "folke/which-key.nvim", tag = "v2.1.0" })

  -- colorcolumn --
  use({ "m4xshen/smartcolumn.nvim" })

  -- statusline --
  use({ "nvim-lualine/lualine.nvim" })

  -- bufferline  --
  use({ "akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons" })

  -- Colorschemes --
  use({ "folke/tokyonight.nvim" })
  use({ "numirias/semshi", run = ":UpdateRemotePlugins" })
  use({ "tanvirtin/monokai.nvim" })
  use({ "vim-python/python-syntax" })

  -- colorizer --
  use({ "norcalli/nvim-colorizer.lua" })

  -- Autopairs --
  use({ "windwp/nvim-autopairs" }) -- integrates with both cmp and treesitter

  -- Transparent --
  use({ "xiyaowong/nvim-transparent" })

  -- cmp plugins for completion --
  use({ "hrsh7th/nvim-cmp" })         -- The completion plugin
  use({ "hrsh7th/cmp-buffer" })       -- buffer completions
  use({ "hrsh7th/cmp-path" })         -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "onsails/lspkind-nvim" })

  -- snippets --
  use({
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp"
  })                                      --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- LSP --
  use({ "neovim/nvim-lspconfig" })           -- enable LSP
  use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
  -- null-ls has beem archived and will no longer receive updates
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters

  -- none-ls is now a community fork of null-ls.nvim
  -- use { "nvimtools/none-ls.nvim" }  -- lack of formatters: blue, rustfmt, flake8

  use({ "RRethy/vim-illuminate" })

  use({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('lspsaga').setup({})
    end,
  })

  -- Telescope --
  use("nvim-lua/popup.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "xiyaowong/telescope-emoji.nvim" })
  use({
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  })
  use({ "nvim-telescope/telescope-media-files.nvim" })

  -- Emoji --
  use({ "stevearc/dressing.nvim" }) -- improve the default vim.ui interfaces
  use({
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true,
      })
    end,
  })

  use({ "hrsh7th/cmp-emoji" }) -- Markdown emoji

  -- Markdown --
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })
  use({ "ellisonleao/glow.nvim" })

  -- Treesitter --
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  -- Toggle terminal --
  use({ "akinsho/toggleterm.nvim" })

  -- Git --
  use({ "lewis6991/gitsigns.nvim" })

  -- DAP --
  use({ "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui" })
  use({ "ravenxrz/DAPInstall.nvim" })

  -- Interactive Repl --
  -- https://github.com/Vigemus/iron.nvim
  use({ "Vigemus/iron.nvim" })

  -- Jupyter support --
  use({ "kana/vim-textobj-user" })
  use({ "kana/vim-textobj-line" })
  use({ "GCBallesteros/vim-textobj-hydrogen" })
  use({ "GCBallesteros/jupytext.nvim" }) -- form from 'goerz/jupytext.vim'

  -- LaTeX --
  use({ "lervag/vimtex" })

  -- Mojo --
  use({ "igorgue/mojo.vim" })

  -- YDict --
  use({ "TimothyYe/vim-ydict" })

  -- Automatically set up your configuration after cloning packer.nvim --
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

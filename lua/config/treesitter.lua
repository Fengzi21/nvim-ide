-- nvim-treesitter is on its new "main" branch: parsers are installed by the
-- `:TSUpdate` build hook in plugins.lua, and highlighting is a Neovim core
-- feature (on by default). The old `nvim-treesitter.configs` API was removed,
-- so the previous `configs.setup({...})` here was dead code. Only the
-- context-aware commentstring plugin still needs an explicit setup.
require("ts_context_commentstring").setup({})

-- Files under <config>/lsp/<name>.lua are auto-discovered by Neovim's
-- native LSP client: they must `return` a config table directly (like
-- ftplugin files), NOT call vim.lsp.config() themselves — doing so makes
-- this module return nil, and vim.lsp.enable() errors with "not a table".
return {
  cmd = {
    "clangd",
    -- "--all-scopes-completion",
    -- "--suggest-missing-includes",
    -- "--background-index",
    -- "--pch-storage=disk",
    -- "--cross-file-rename",
    -- "--log=info",
    -- "--completion-style=detailed",
    -- "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
    -- "--clang-tidy",
    "--offset-encoding=utf-16",
    -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
    '--fallback-style={BasedOnStyle: llvm, ColumnLimit: 100}',
    -- "--header-insertion=never",
    -- "--query-driver=<list-of-white-listed-complers>"
  },
}

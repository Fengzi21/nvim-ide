-- Was previously registered under the name "tex" (typo), which meant it
-- never matched the "ltex" entry in config/lsp/servers.lua and so was
-- always silently ignored in favour of lspconfig's built-in defaults.
return {
  filetypes = { "tex", "bib", "markdown", "gitcommit" },
}

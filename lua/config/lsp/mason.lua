local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
  return
end

local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lspconfig then
  return
end

mason.setup({
  ui = {
    border = "rounded",
  },
})

-- Ensure LSP servers are installed. Actual server configs remain in lua/lsp/*.
local servers = require("config.lsp.servers")

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

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

-- Ensure only mason-lspconfig supported servers are installed.
-- Your full server list (including non-mason ones like `mojo`) remains in config.lsp.servers.
local desired_servers = require("config.lsp.servers")
local available_servers = mason_lspconfig.get_available_servers()

local available = {}
for _, name in ipairs(available_servers) do
  available[name] = true
end

local ensure = {}
local skipped = {}
for _, name in ipairs(desired_servers) do
  if available[name] then
    table.insert(ensure, name)
  else
    table.insert(skipped, name)
  end
end

if #skipped > 0 then
  vim.schedule(function()
    vim.notify(
      "Mason: skipping unsupported LSP servers: " .. table.concat(skipped, ", "),
      vim.log.levels.WARN
    )
  end)
end

mason_lspconfig.setup({
  ensure_installed = ensure,
  automatic_installation = true,
})

local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
  return
end

local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lspconfig then
  return
end

local platform = require("config.util.platform")

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

-- Servers Mason installs through a language toolchain instead of a prebuilt
-- binary. On a fresh Windows install these CLIs are often missing, and Mason's
-- automatic installer then prints "failed to install <server>" on every
-- startup. Detect them up front and skip with an actionable hint instead.
local prerequisites = {
  -- gopls = "go",
  pyright = "npm",
  bashls = "npm",
  jsonls = "npm",
  yamlls = "npm",
}

local install_hints = {
  -- go = "winget install GoLang.Go",
  npm = "winget install OpenJS.NodeJS.LTS",
}

local ensure = {}
local skipped = {}
local missing = {}
for _, name in ipairs(desired_servers) do
  if not available[name] then
    table.insert(skipped, name)
  elseif prerequisites[name] and not platform.has_exe(prerequisites[name]) then
    table.insert(missing, name)
  else
    table.insert(ensure, name)
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

if #missing > 0 then
  vim.schedule(function()
    local msgs = {}
    for _, name in ipairs(missing) do
      local cli = prerequisites[name]
      local hint = install_hints[cli]
      table.insert(msgs, hint and (name .. " (needs `" .. cli .. "`, try: " .. hint .. ")") or (name .. " (needs `" .. cli .. "`)"))
    end
    vim.notify(
      "Mason: skipped servers with missing toolchains — " .. table.concat(msgs, "; "),
      vim.log.levels.WARN
    )
  end)
end

mason_lspconfig.setup({
  ensure_installed = ensure,
  automatic_installation = true,
})

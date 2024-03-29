local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "rust_analyzer",
  -- "ccls",
  "clangd",
  "fortls",
  "taplo",
  "ansiblels",
  "awk_ls",
  "jdtls",
  "ltex",
  "marksman",
  "asm_lsp",
  "cmake",
  "mojo"
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "lua_ls" then
    local luals_opts = require "user.lsp.settings.luals"
    opts = vim.tbl_deep_extend("force", luals_opts, opts)
  end

  if server == "pylsp" then
    local pylsp_opts = require "user.lsp.settings.pylsp"
    opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "fortls" then
    local fortls_opts = require "user.lsp.settings.fortls"
    opts = vim.tbl_deep_extend("force", fortls_opts, opts)
  end

  if server == "clangd" then
    local clangd_opts = require "user.lsp.settings.clangd"
    opts = vim.tbl_deep_extend("force", clangd_opts, opts)
  end

  if server == "mojo" then
    local mojo_opts = require "user.lsp.settings.mojo"
    opts = vim.tbl_deep_extend("force", mojo_opts, opts)
  end

  lspconfig[server].setup(opts)
end

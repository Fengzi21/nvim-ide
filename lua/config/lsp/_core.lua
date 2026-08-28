local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

M.setup = function()
  -- Neovim 0.10+ prefers configuring sign text directly through
  -- vim.diagnostic.config() instead of vim.fn.sign_define(); the old
  -- sign_define API still works but is soft-deprecated.
  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", ":lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  -- server_capabilities uses LSP-protocol camelCase field names; the old
  -- snake_case aliases (document_formatting) are no longer normalized by
  -- recent nvim-lspconfig versions and silently do nothing.
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  lsp_keymaps(bufnr)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

-- NOTE: with Neovim 0.11+'s native `vim.lsp.enable()` + `nvim/lsp/*.lua`
-- setup, there is no more `require("lspconfig")[server].setup({on_attach=...})`
-- call site to hook into — that used to be where `M.on_attach` (and thus the
-- `gd` keymap) got wired up. It must be attached manually via `LspAttach`,
-- and default capabilities must be set globally via `vim.lsp.config('*', ...)`.
M.setup()

vim.lsp.config("*", { capabilities = M.capabilities })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      M.on_attach(client, args.buf)
    end
  end,
})

return M

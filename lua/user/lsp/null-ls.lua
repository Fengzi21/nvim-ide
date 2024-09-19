local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
local completion = null_ls.builtins.completion

-- https://github.com/prettier-solidity/prettier-plugin-solidity
---@diagnostic disable-next-line: redundant-parameter
null_ls.setup {
  debug = false,
  sources = {
    completion.spell,
    formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    -- formatting.black.with {
    --   extra_args = {
    --     "--fast",
    --     "--line-length=120",
    --   },
    -- },
    formatting.blue.with {
      extra_args = {
        "--fast",
        "--line-length=120",
      },
    },
    formatting.stylua.with {
      extra_args = {
        "--column-width=120",
        "--line-endings=Unix",
        "--indent-type=Spaces",
        "--indent-width=2",
        "--quote-style=AutoPreferDouble",
        "--call-parentheses=Always",
        "--collapse-simple-statement=Never",
      },
    },
    formatting.rustfmt,
    formatting.fprettify.with {
      extra_args = {
        "--indent=2",
        "--whitespace=3",
        "--enable-decl",
      },
    },
    diagnostics.flake8,
  },
}

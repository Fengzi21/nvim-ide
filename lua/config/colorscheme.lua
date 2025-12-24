local schemes = {
  tn = "tokyonight",
  mk = "monokai",
  mkp = "monokai_pro",
  mks = "monokai_soda",
}

vim.g.python_highlight_all = 1

---@diagnostic disable-next-line: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. schemes.mk)
if not status_ok then
  vim.notify("colorscheme" .. schemes.mk .. "not found!")
  return
end

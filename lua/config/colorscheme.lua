local status_ok, _ = pcall(vim.cmd, "colorscheme monokai")
if not status_ok then
  vim.notify("colorscheme monokai not found!")
  return
end

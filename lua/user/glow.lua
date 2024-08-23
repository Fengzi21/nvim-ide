local status_ok, glow = pcall(require, "glow")
if not status_ok then
  return
end

glow.setup({
  border = "rounded",
  width = 120,
  height = 100,
})

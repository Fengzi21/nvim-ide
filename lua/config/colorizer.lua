local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

colorizer.setup({
  filetypes = {
    "*", -- Highlight all files, but customize some others.
    css = { css_fn = true }, -- Enable parsing rgb(...) functions in css.
  },
})

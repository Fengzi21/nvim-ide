local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.load_extension("media_files")

---@diagnostic disable-next-line: redundant-parameter
telescope.setup({
  extensions = {
    media_files = {
      -- filetypes whitelist
      filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
    },
  },
})

local smarcc_status_ok, smartcc = pcall(require, "smartcolumn")
if not smarcc_status_ok then
  return
end

local config = {
   colorcolumn = { "80", "100", "120" },
   disabled_filetypes = { "help", "text", "markdown" },
   custom_colorcolumn = {},
   scope = "file",
}

smartcc.setup(config)

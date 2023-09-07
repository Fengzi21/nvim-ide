local web_devicons_status_ok, web_devicons = pcall(require, "nvim-web-devicons")
if not web_devicons_status_ok then
  return
end

web_devicons.setup {
  override = {
    f90 = {
      icon = "F",
      color = "#563b70",
      cterm_color = "53",
      name = "Fortran",
    }
  }
}

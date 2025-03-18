-- markdown-preview --

-- set to 1, the nvim will auto close current preview window when changing
-- from Markdown buffer to another buffer
-- default: 1
vim.g.mkdp_auto_close = 0

local username = vim.fn.system("whoami"):gsub("\n", "") -- Remove newline

if username == "liuyf" then
  vim.g.mkdp_open_to_the_world = 1
  vim.g.mkdp_open_ip = "10.201.36.11"
  vim.g.mkdp_port = 7777
  vim.g.mkdp_echo_preview_url = 1
end

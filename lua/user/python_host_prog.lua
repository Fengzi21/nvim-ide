-- Get the hostname
local hostname = vim.fn.system("hostname"):gsub("\n", "") -- Remove newline

-- Set python3_host_prog for specific platform
local conda_version = "miniconda3"

if hostname == "ws" then
  conda_version = "anaconda3"
end

vim.g.python3_host_prog = "~/" .. conda_version .. "/bin/python"

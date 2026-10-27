-- Centralised platform detection so every other config file can share
-- one consistent way of asking "what OS/shell am I on" instead of each
-- file re-inventing its own check (os_uname vs package.config vs has()).
local M = {}

-- Prefer the new `vim.uv` name (Neovim 0.10+); `vim.loop` was removed in
-- Neovim 0.11, so referencing it unconditionally would crash on Windows/Linux
-- with "attempt to index a nil value".
local uv = vim.uv or vim.loop

M.is_windows = (vim.fn.has("win32") == 1) or (vim.fn.has("win64") == 1)
M.is_mac = uv and uv.os_uname().sysname == "Darwin"
M.is_linux = not M.is_windows and not M.is_mac

-- WSL runs a Linux kernel but often wants Windows-side behaviour (clipboard, browsers, etc.)
M.is_wsl = M.is_linux and vim.fn.has("wsl") == 1

-- Cheap, cached executable lookup.
local exec_cache = {}
function M.has_exe(name)
  if exec_cache[name] == nil then
    exec_cache[name] = vim.fn.executable(name) == 1
  end
  return exec_cache[name]
end

-- Join path components with the platform separator. On Windows this produces
-- backslashes so it matches Neovim's internal path strings (stdpath, packpath,
-- rtp entries) exactly, unlike a naive `.. "/" ..` concatenation.
function M.join(...)
  if vim.fs and vim.fs.joinpath then
    return vim.fs.joinpath(...)
  end
  return table.concat({ ... }, "/")
end

-- Preferred interactive shell for embedded/toggleterm-style terminals.
function M.default_shell()
  if M.is_windows then
    return M.has_exe("pwsh") and "pwsh" or "powershell"
  end
  return vim.o.shell
end

return M

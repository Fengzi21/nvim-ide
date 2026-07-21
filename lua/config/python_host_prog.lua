-- Was previously hardcoded to a Unix-style "~/<conda>/bin/python" path,
-- which doesn't exist on Windows (Scripts\python.exe layout) and relied
-- on a `hostname == "ws"` machine-name hack. This now works the same on
-- all three platforms and falls back gracefully if conda isn't found.
local platform = require("config.util.platform")

local function first_existing(candidates)
  for _, path in ipairs(candidates) do
    local expanded = vim.fn.expand(path)
    if vim.fn.executable(expanded) == 1 then
      return expanded
    end
  end
  return nil
end

local python

if platform.is_windows then
  python = first_existing({
    "~/miniconda3/python.exe",
    "~/anaconda3/python.exe",
    "~/AppData/Local/Programs/Python/Python3*/python.exe",
  })
else
  python = first_existing({
    "~/miniconda3/bin/python",
    "~/anaconda3/bin/python",
    "/opt/homebrew/bin/python3", -- Apple Silicon Homebrew
    "/usr/local/bin/python3",
  })
end

-- Fall back to whatever "python3"/"python" resolves to on PATH.
if not python then
  python = vim.fn.exepath("python3")
  if python == "" then
    python = vim.fn.exepath("python")
  end
  if python == "" then
    python = nil
  end
end

if python then
  vim.g.python3_host_prog = python
end

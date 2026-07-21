-- vim.fn.exepath works cross-platform (Windows/macOS/Linux); the old
-- `vim.fn.system("which python")` relied on a Unix-only `which` binary
-- and silently produced an empty string on Windows.
local python = vim.fn.exepath("python") -- currently unused below, kept for future pythonPath wiring

return {
  settings = {
    python = {
      -- pythonPath = python,
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = "off",
        diagnosticMode = "workspace",
        diagnosticSeverityOverrides = {
          reportUnusedImport = "none",
          reportUnusedClass = "none",
          reportUnusedFunction = "none",
          reportUnusedVariable = "none",
          reportOptionalSubscript = "none",
          reportAssignmentType = "none",
          reportIncompatibleMethodOverride = "none",
        },
      },
    },
  },
}

local python = vim.fn.system("which python"):gsub("\n", "") -- Remove newline

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

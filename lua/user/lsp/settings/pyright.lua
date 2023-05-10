return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = "off",
        diagnosticMode = "workspace",
        diagnosticSeverityOverrides = {
          reportUnusedImport = "none",
          reportUnusedClass = "none",
          reportUnusedFunction = "none",
          reportUnusedVariable = "none",
        },
      },
    },
  },
}

-- Global defaults (capabilities, diagnostics, handlers)
require("config.lsp._core")

-- Manage LSP server binaries via Mason
require("config.lsp.mason")

-- Enable servers (must be explicit in 0.11+)
require("config.lsp.enable")

require("config.lsp.format.none_ls")


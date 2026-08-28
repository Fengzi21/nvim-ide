local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
  return
end

transparent.setup({
  -- table/string: additional groups that should be cleared
  extra_groups = {
    -- for akinsho/bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",

    -- for Telescope
    "TelescopeMatching",
    "TelescopeSelection",
    "TelescopePromptTitle",
    "TelescopePromptPrefix",
    "TelescopePromptCounter",
    "TelescopePromptNormal",
    "TelescopePromptBorder",
    "TelescopeResultsTitle",
    "TelescopeResultsNormal",
    "TelescopeResultsBorder",
    "TelescopePreviewTitle",
    "TelescopePreviewNormal",
    "TelescopePreviewBorder",
  },
})

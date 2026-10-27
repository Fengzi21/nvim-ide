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

-- Default to transparent on fresh installs. The plugin persists its state to
-- stdpath('data')/transparent_cache, so a brand-new Windows machine has no
-- cache and therefore starts opaque — the README's manual `:TransparentEnable`
-- step is easy to miss. Enable once when no saved state exists; afterwards the
-- plugin's own cache (read during require) is respected, so `:TransparentToggle`
-- still works as expected.
local cache = vim.fn.stdpath("data") .. package.config:sub(1, 1) .. "transparent_cache"
if vim.fn.filereadable(cache) ~= 1 then
  vim.g.transparent_enabled = true
end

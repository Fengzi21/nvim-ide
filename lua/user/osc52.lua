local status_ok, osc52 = pcall(require, "osc52")
if not status_ok then
  return
end

local keymap = vim.keymap.set -- Shorten function name

-- Clipboard --
keymap("n", "<leader>c", require("osc52").copy_operator, { expr = true })
keymap("n", "<leader>cc", "<leader>c_", { remap = true })
keymap("v", "<leader>c", require("osc52").copy_visual)

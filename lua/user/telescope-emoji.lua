local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

---@diagnostic disable-next-line: redundant-parameter
telescope.setup({
  extensions = {
    emoji = {
      action = function(emoji)
        -- argument emoji is a table.
        -- {name="", value="", cagegory="", description=""}

        vim.fn.setreg("*", emoji.value)
        -- print([[Press p or "*p to paste this emoji]] .. emoji.value)

        -- insert emoji when picked
        vim.api.nvim_put({ emoji.value }, "c", false, true)
      end,
    },
  },
})

telescope.load_extension("emoji")

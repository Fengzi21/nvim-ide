vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
vim.api.nvim_set_keymap("n", "<a-n>", ':lua require"illuminate".next_reference{wrap=true}<CR>', { noremap = true })
vim.api.nvim_set_keymap(
  "n",
  "<a-p>",
  ':lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>',
  { noremap = true }
)
